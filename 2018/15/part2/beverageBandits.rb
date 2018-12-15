class QueueNode
    def initialize(point, previous)
        @point = point
        @distance = 0
        @steps = []

        if !previous.nil?
            @distance = previous.distance + 1
            if distance > 1
                @steps = previous.steps.dup
                @steps.push(previous.point)
            end
        end
    end
    attr_reader :point, :distance, :steps

    def firstStep
        if distance == 1
            return @point
        else
            return @steps[0]
        end
    end

    def to_s
        steps = @steps.map{|s| s.to_s}
        return "#{@point} #{@distance} #{steps}"
    end
end

class Point
    def initialize(x, y)
        @x = x
        @y = y
    end
    attr_reader :x, :y

    def ==(other)
        return (other.x == x and other.y == y)
    end

    def nearest
        return [Point.new(x, y - 1), Point.new(x - 1, y), Point.new(x + 1, y), Point.new(x, y + 1)]
    end

    def to_s
        return "#{@x}x#{@y}"
    end
end

class Unit
    def initialize(type, position)
        @type = type
        @position = position
        @hp = 200
        @damage = 3
    end
    attr_reader :type, :hp, :position
    attr_writer :damage

    def x() position.x end
    def y() position.y end
    def isDead() @hp <= 0 end
    def status() "#{@type}(#{@hp})" end
    def sort_str() "#{position.y.to_s.rjust(2, '0')}x#{position.x.to_s.rjust(2, '0')}" end

    def takeDamage
        @hp -= @damage
    end

    def attackTarget(grid, units)
        targets = units.select{|unit| unit.type != type and !unit.isDead}
        if targets.length == 0
            return false
        end

        target = findTarget(targets)
        if target.nil?
            moveToBestTarget(grid, targets)
            target = findTarget(targets)
        end

        if !target.nil?
            target.takeDamage
            if target.isDead
                if target.type == 'E'
                    return false
                end
                grid[target.y][target.x] = 0
            end
        end

        return true
    end

    def to_s
        return "#{status} #{@position}"
    end

    private

    def findTarget(targets)
        positions = @position.nearest
        targets = targets.select{|target| positions.include?(target.position)}

        if targets.length == 0
            return nil
        elsif targets.length == 1
            return targets[0]
        else
            targets.sort_by{|target| target.hp}[0]
        end
    end

    def moveToBestTarget(grid, targets)
        maxDistance = grid.length * grid[0].length
        bestTarget = nil
        bestNode = nil

        targets.each do |target|
            src = @position
            dst = target.position

            best = nil
            dst.nearest.each do |point|
                node = breadthFirstSearch(grid, src, point, maxDistance)
                if !node.nil?
                    if best.nil? or node.distance < best.distance
                        best = node
                    end
                end
            end

            if !best.nil?
                if bestTarget.nil? or best.distance < maxDistance
                    maxDistance = best.distance
                    bestTarget = target
                    bestNode = best
                end
            end
        end

        if !bestNode.nil?
            destination = bestNode.firstStep
            grid[@position.y][@position.x] = 0
            @position = Point.new(destination.x, destination.y)
            grid[@position.y][@position.x] = self
        end
    end

    def breadthFirstSearch(grid, src, dst, maxDistance)
        if grid[dst.y][dst.x] != 0
            return nil
        end

        visited = Hash.new(0)
        visited[src.to_s] = 1
    
        colNum = [-1,  0, 0, 1]
        rowNum = [ 0, -1, 1, 0]

        queue = Array.new
        start = QueueNode.new(src, nil)
        queue.push(start)

        while queue.size != 0
            current = queue.first
            point = current.point

            if point.x == dst.x and point.y == dst.y
                return current
            end

            queue.shift

            if current.distance < maxDistance
                for i in 0..3
                    x = point.x + rowNum[i]
                    y = point.y + colNum[i]

                    pos = Point.new(x, y)
                    if grid[y][x] == 0 and visited[pos.to_s] == 0
                        visited[pos.to_s] = 1

                        cell = QueueNode.new(pos, current)
                        queue.push(cell)
                    end
                end
            end
        end
    
        return nil
    end
end

def executeRound(grid, units)
    units.each do |unit|
        if unit.isDead
            next
        end

        if !unit.attackTarget(grid, units)
            return false
        end
    end

    return true
end

def executeRounds(grid, units)
    rounds = 0
    while true
        canContinue = executeRound(grid, units)

        deadUnits = units.select{|unit| unit.isDead}
        if deadUnits.length > 0
            if !deadUnits.find{|unit| unit.type == 'E'}.nil?
                return -1
            end
            units -= deadUnits
        end

        if !canContinue
            break
        end

        units = units.sort_by{|unit| unit.sort_str}

        rounds += 1
    end

    return rounds * units.map{|unit| unit.hp}.sum
end

def printGrid(grid, units)
    height = grid.length
    width = grid[0].length

    for y in 0..height-1
        units_on_row = []
        for x in 0..width-1
            if grid[y][x] == 1
                print '#'
            elsif grid[y][x] == 0
                print '.'
            else
                units_on_row.push(grid[y][x])
                print grid[y][x].type
            end
        end

        units_on_row.each do |unit|
            print " #{unit.status}"
        end
        puts
    end
end

def beverageBandits(input)
    startGrid = []
    startUnits = []

    y = 0
    input.each do |line|
        x = 0
        startGrid.push([])
        line.chars.each do |char|
            case char
            when '.'
                startGrid[y][x] = 0
            when '#'
                startGrid[y][x] = 1
            when 'G', 'E'
                unit = Unit.new(char, Point.new(x, y))
                startUnits.push(unit)
                startGrid[y][x] = unit
            end
            x += 1
        end
        y += 1
    end

    puts
    printGrid(startGrid, startUnits)
    puts

    score = -1
    damage = 4
    while score == -1
        grid = []
        startGrid.each do |row|
            grid.push(row.dup)
        end
        units = startUnits.map{|unit| unit.dup}
        units.each{|unit| grid[unit.y][unit.x] = unit}
        units.each{|unit| unit.damage = unit.type == 'G' ? damage : 3 }

        score = executeRounds(grid, units)
        puts
        printGrid(grid, units)
        puts "#{damage} = #{score}"

        if score != -1
            return score
        end
        damage += 1
    end
end