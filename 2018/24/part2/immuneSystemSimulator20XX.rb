class Group
    def initialize(teamName, index, units, hp)
        @teamName = teamName
        @index = index
        @units = units
        @hp = hp
        @weakness = []
        @immune = []
        @attack = ""
        @damage = 0
        @initiative = 0
        @originalUnits = units
    end
    attr_reader :teamName, :index, :units, :attack, :initiative

    def boost(value) @damageWithBoost = @damage + value end
    def reset() @units = @originalUnits end
    def effectivePower() units * @damageWithBoost end

    def addWeakness(weakness)
        @weakness.push(weakness)
    end

    def addImmune(immune)
        @immune.push(immune)
    end

    def setAttack(type, damage)
        @attack = type
        @damage = damage
        @damageWithBoost = @damage
    end

    def setInitiative(initiative)
        @initiative = initiative
    end

    def damageFrom(attacker)
        if @immune.include?(attacker.attack)
            return 0
        end

        if @weakness.include?(attacker.attack)
            return attacker.effectivePower * 2
        end

        return attacker.effectivePower
    end

    def defendAttackFrom(attacker)
        if @units == 0
            return
        end

        startUnits = @units

        damage = damageFrom(attacker)
        while @units > 0
            if damage >= @hp
                damage -= @hp
                @units -= 1
            else
                break
            end
        end

        return startUnits - @units
    end

    def to_s
        return "#{@teamName} index=#{@index} units=#{@units} hp=#{@hp} remaining=#{@units} weakness=#{@weakness} immune=#{@immune} attack=#{@attack} damage=#{@damageWithBoost}) effectivePower=#{effectivePower} initiative=#{@initiative}"
    end
end

def readWeaknessesAndImmunities(group, input)
    i = 7
    if input[i] == "with"
        return i-1
    end

    info = []
    while input[i][-1] != ")"
        info.push(input[i])
        i += 1
    end
    info.push(input[i])

    state = ""
    info.each do |item|
        item.sub!("(", "")
        item.sub!(")", "")
        item.sub!(",", "")
        item.sub!(";", "")

        case item
        when "weak", "immune"
            state = item
        when "to"
        else
            if state == "weak"
                group.addWeakness(item)
            else
                group.addImmune(item)
            end
        end
    end

    return i
end

def readTeam(input, teamName)
    team = []

    index = 1
    input.each do |line|
        info = line.split(" ")
        units = info[0].to_i
        hp = info[4].to_i
        group = Group.new(teamName, index, units, hp)

        i = readWeaknessesAndImmunities(group, info)
        damage = info[i + 6].to_i
        type = info[i + 7]
        group.setAttack(type, damage)

        initiative = info[i + 11].to_i
        group.setInitiative(initiative)

        team.push(group)
        index += 1
    end

    return team
end

def printTeam(team, name = "")

    puts "#{name != "" ? name : team[0].teamName}:"
    if team.length == 0
        puts "No groups remain."
    else
        team.each do |group|
            puts "Group #{group.index} contains #{group.units} units."
        end
    end
end

def selectTargets(attackers, targets)

    attackersByEffectivePower =  Hash.new() { [] }
    attackers.sort_by(&:initiative).reverse.each do |attacker|
        attackersByEffectivePower[attacker.effectivePower] = attackersByEffectivePower[attacker.effectivePower].push(attacker)
    end

    result = {}

    attackersByEffectivePower.sort_by{|effectivePower,_|effectivePower}.reverse.each do |_,attackers|
        attackers.each do |attacker|
            possibleTargets = Hash.new() { [] }
            targets.each do |target|
                damage = target.damageFrom(attacker)
                if damage > 0
                    possibleTargets[damage] = possibleTargets[damage].push(target)
                end
            end

            if possibleTargets.length == 0
                next
            end

            damage, bestTargets = possibleTargets.max_by{|k,v| k}
            if bestTargets.length == 1
                bestTarget = bestTargets[0]
            else
                possibleTargets.clear
                bestTargets.each do |target|
                    possibleTargets[target.effectivePower] = possibleTargets[target.effectivePower].push(target)
                end

                effectivePower, bestTargets = possibleTargets.max_by{|k,v| k}
                if bestTargets.length == 1
                    bestTarget = bestTargets[0]
                else
                    bestTarget = bestTargets.max_by(&:initiative)
                end
            end

            result[attacker] = bestTarget
            targets.delete(bestTarget)
        end
    end

    return result
end

def fight(immuneSystem, infection, boost)
    immuneSystem.each do |group|
        group.reset()
        group.boost(boost)
    end

    infection.each do |group|
        group.reset()
    end

    while immuneSystem.length > 0 and infection.length > 0

        startUnits = (immuneSystem + infection).map(&:units).sum

        infectionAttackers = selectTargets(infection, immuneSystem.dup)
        immuneSystemAttackers = selectTargets(immuneSystem, infection.dup)

        attackers = infectionAttackers.merge(immuneSystemAttackers)
        attackers.sort_by{|a,t|-a.initiative}.each do |attacker,target|
            killedUnits = target.defendAttackFrom(attacker)
        end

        immuneSystem = immuneSystem.select{|group| group.units > 0}
        infection = infection.select{|group| group.units > 0}

        if (immuneSystem + infection).map(&:units).sum == startUnits
            printTeam(immuneSystem, "Immune System")
            printTeam(infection, "Infection")
            return 0
        end
    end

    printTeam(immuneSystem, "Immune System")
    printTeam(infection, "Infection")
    puts

    return immuneSystem.length == 0 ? 0 : immuneSystem.map(&:units).sum
end

def immuneSystemSimulator20XX(input)
    for i in 0..input.length
        if input[i].strip == ""
            break
        end
    end

    immuneSystem = readTeam(input[1..i-1], "Immune System")
    infection = readTeam(input[i+2..-1], "Infection")

    boost = 1
    while true
        total = fight(immuneSystem, infection, boost)
        if total != 0
            break
        end
        boost += 1
    end

    return total
end