module RegionType
    Rocky = 0
    Wet = 1
    Narrow = 2
    Mouth = 3
    Target = 4
end

module Tool
    Torch = 0
    ClimbingGear = 1
    Neither = 2
end

class Region
    def initialize(x, y, type)
        @x = x
        @y = y
        @type = type

        @t = -1
        @c = -1
        @n = -1

        if type == RegionType::Mouth
            @t = 0
        end
    end
    attr_reader :type, :t, :c, :n, :x, :y

    def useAsPrevious(cave, previous)
        if previous.type == RegionType::Target
            return 0
        end

        changes = setTorch(cave, previous)
        if @type != RegionType::Target
            changes += setClimbingGear(cave, previous)
            changes += setNeither(cave, previous)
        end

        possible = []
        possible = possible.push(@t) if @t > -1
        possible = possible.push(@c) if @c > -1
        possible = possible.push(@n) if @n > -1

        return changes
    end

    def asCell
        names = []
        names = names.push("c=#{@c.to_s.rjust(2, ' ')}") if @c > -1
        names = names.push("n=#{@n.to_s.rjust(2, ' ')}") if @n > -1
        names = names.push("t=#{@t.to_s.rjust(2, ' ')}") if @t > -1

        return "[#{names.join(",").ljust(9, ' ')}]"
    end

    def previous(cave, previousTool)
        possible = [cave["#{@x-1}x#{@y}"], cave["#{@x}x#{@y-1}"], cave["#{@x+1}x#{@y}"], cave["#{@x}x#{@y+1}"]].compact

        possible.each do |region|
            case previousTool
            when Tool::Torch
                if @t-region.n == 8
                    return [region, Tool::Neither]
                end
                if @t-region.c == 8
                    return [region, Tool::ClimbingGear]
                end
                if @t-region.t == 1
                    return [region, Tool::Torch]
                end
            when Tool::ClimbingGear
                if @c-region.t == 8
                    return [region, Tool::Torch]
                end
                if @c-region.n == 8
                    return [region, Tool::Neither]
                end
                if @c-region.c == 1
                    return [region, Tool::ClimbingGear]
                end
            when Tool::Neither
                if @n-region.t == 8
                    return [region, Tool::Torch]
                end
                if @n-region.c == 8
                    return [region, Tool::ClimbingGear]
                end
                if @n-region.n == 1
                    return [region, Tool::Neither]
                end
            end
        end

        return nil
    end

    def to_s
        return "#{typeChar} t=#{@t},c=#{@c},n=#{@n} (#{@x}x#{@y})"
    end

    def typeName
        case @type
        when RegionType::Rocky
            return "rocky"
        when RegionType::Wet
            return "wet"
        when RegionType::Narrow
            return "narrow"
        when RegionType::Target
            return "target"
        end
    end

    def typeChar
        case @type
        when RegionType::Rocky
            return "."
        when RegionType::Wet
            return "="
        when RegionType::Narrow
            return "|"
        when RegionType::Mouth
            return "M"
        when RegionType::Target
            return "T"
        end
    end

    private

    def setTorch(cave, previous)
        if type == RegionType::Wet or previous.type == RegionType::Wet
            return 0
        end

        possible = []
        possible = possible.push(previous.t + 1) if previous.t > -1
        possible = possible.push(previous.c + 8) if previous.c > -1
        possible = possible.push(previous.n + 8) if previous.n > -1

        if possible.length == 0
            return 0
        end

        newT = possible.min
        if @t == -1
            @t = newT
            return 1
        end

        if newT < @t
            oldT = @t
            @t = newT

            if !previous(cave, Tool::Torch).nil?
                return 1
            end

            @t = oldT
        end

        return 0
    end

    def setClimbingGear(cave, previous)
        if type == RegionType::Narrow or previous.type == RegionType::Narrow
            return 0
        end

        possible = []
        possible = possible.push(previous.t + 8) if previous.t > -1
        possible = possible.push(previous.c + 1) if previous.c > -1
        possible = possible.push(previous.n + 8) if previous.n > -1

        if possible.length == 0
            return 0
        end

        newC = possible.min
        if @c == -1
            @c = newC
            return 1
        end

        if newC < @c
            oldC = @c
            @c = newC

            if !previous(cave, Tool::ClimbingGear).nil?
                return 1
            end

            @c = oldC
        end

        return 0
    end

    def setNeither(cave, previous)
        if type == RegionType::Rocky or previous.type == RegionType::Rocky
            return 0
        end

        possible = []
        possible = possible.push(previous.t + 8) if previous.t > -1
        possible = possible.push(previous.c + 8) if previous.c > -1
        possible = possible.push(previous.n + 1) if previous.n > -1

        if possible.length == 0
            return 0
        end

        newN = possible.min
        if @n == -1
            @n = newN
            return 1
        end

        if newN < @n
            oldN = @n
            @n = newN

            if !previous(cave, Tool::Neither).nil?
                return 1
            end

            @n = oldN
        end

        return 0
    end
end

def setErosionLevel(erosions, depth, x, y)
    if y == 0
        result = ((x * 16807) + depth) % 20183
    elsif x == 0
        result = ((y * 48271) + depth) % 20183
    else
        result = ((erosions["#{x-1}x#{y}"] * erosions["#{x}x#{y-1}"]) + depth) % 20183
    end

    erosions["#{x}x#{y}"] = result
end

def createCave(erosions, targetX, targetY, maxX, maxY)
    cave = {}

    erosions.each do |k,v|
        x,y = k.split("x").map(&:to_i)
        cave[k] = Region.new(x, y, v % 3)
    end

    cave["0x0"] = Region.new(0, 0, RegionType::Mouth)
    cave["#{targetX}x#{targetY}"] = Region.new(targetX, targetY, RegionType::Target)

    for x in 1..maxX
        cave["#{x}x0"].useAsPrevious(cave, cave["#{x-1}x0"])
    end

    for y in 1..maxY
        cave["0x#{y}"].useAsPrevious(cave, cave["0x#{y-1}"])
    end

    return cave
end

def walkDown(cave, maxX, maxY)
    changes = 0

    for y in 1..maxY
        for x in 1..maxX
            changes += cave["#{x}x#{y}"].useAsPrevious(cave, cave["#{x-1}x#{y}"])
            changes += cave["#{x}x#{y}"].useAsPrevious(cave, cave["#{x}x#{y-1}"])
        end
    end

    return changes
end

def walkUp(cave, maxX, maxY)
    changes = 0


    y = maxY - 1
    while y >= 0
        x = maxX - 1
        while x >= 0
            if !(x == 0 and y == 0)
                changes += cave["#{x}x#{y}"].useAsPrevious(cave, cave["#{x+1}x#{y}"])
                changes += cave["#{x}x#{y}"].useAsPrevious(cave, cave["#{x}x#{y+1}"])
            end
            x -= 1
        end
        y -= 1
    end

    return changes
end

def printCave(cave, maxX, maxY, route)

    colors = Hash.new(0)

    newToolColor = 0
    while route.length > 0
        step = route.shift
        if (step.class.to_s == "String")
            case route.shift
            when "torch"
                newToolColor = 31
            when "climbing gear"
                newToolColor = 32
            when "neither"
                newToolColor = 35
            end
        else
            if newToolColor != 0
                colors["#{step.x}x#{step.y}"] = newToolColor
                newToolColor = 0
            else
                colors["#{step.x}x#{step.y}"] = 37
            end
        end
    end

    print "\e[1;30m"
    for y in 0..maxY
        for x in 0..maxX
            char = cave["#{x}x#{y}"].typeChar
            color = colors["#{x}x#{y}"]
            if char == 'T' or char == 'M'
                color = 31
            end
            if color != 0
                print "\e[1;#{color}m"
            end
            print char
            if color!= 0
                print "\e[1;30m"
            end
        end
        puts
    end
end

def toolName(tool)
    case tool
    when Tool::Torch
        return "torch"
    when Tool::ClimbingGear
        return "climbing gear"
    when Tool::Neither
        return "neither"
    end
end

def createRoute(cave, targetX, targetY)
    route = []

    current = cave["#{targetX}x#{targetY}"]
    currentTool = Tool::Torch
    route.push(current)

    while true

        previous = current.previous(cave, currentTool)
        if previous.nil?
            puts "PANIC"
            exit 0
        end

        current = previous[0]
        newTool = previous[1]
        if currentTool != newTool
            route.push(toolName(currentTool))
            route.push(toolName(newTool))

            currentTool = newTool
        end

        if current.type == RegionType::Mouth
            break
        end

        route.push(current)
    end

    return route.reverse
end

def printRoute(route)

    puts "Starting at 0x0 holding the torch. (0)"
    duration = 0
    while route.length > 0
        step = route.shift
        if (step.class.to_s == "String")
            duration += 7
            nextStep = route.shift
            puts "Switching from #{step} to #{nextStep}. (#{duration})"
        else
            duration += 1
            puts "Walking to #{step.typeName} area #{step.x}x#{step.y}. (#{duration})"
        end
    end
end

def modeMaze(input)
    depth = input[0].split(" ")[1].to_i
    targetX, targetY = input[1][8..-1].split(",").map(&:to_i)

    extra = 15
    maxX = targetX + extra
    maxY = targetY + extra

    erosions = {}
    for y in 0..maxY
        for x in 0..maxX
            if y == targetY and x == targetX
                erosions["#{x}x#{y}"] = erosions["0x0"]
            else
                setErosionLevel(erosions, depth, x, y)
            end
        end
    end

    cave = createCave(erosions, targetX, targetY, maxX, maxY)

    while true
        changes = walkDown(cave, maxX, maxY)
        if changes == 0
            break
        end
        changes = walkUp(cave, maxX, maxY)
        if changes == 0
            break
        end
    end

    route = createRoute(cave, targetX, targetY)

    printCave(cave, maxX, maxY, route.dup)

    printRoute(route)

    return cave["#{targetX}x#{targetY}"].t
end