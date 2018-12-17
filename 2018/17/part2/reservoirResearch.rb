class Point
    def initialize(x, y)
        @x = x
        @y = y
    end
    attr_reader :x, :y

    def to_s
        return "#{@x}x#{@y}"
    end
end

class Clay
    def initialize(startX, endX, startY, endY)
        @startX = startX
        @endX = endX
        @startY = startY
        @endY = endY
        @offset = 0
    end
    attr_reader :startY, :endY
    attr_writer :offset

    def startX() @startX - @offset end
    def endX() @endX - @offset end

    def to_s
        return "x=#{@startX}..#{@endX} y=#{@startY}..#{@endY}"
    end
end

def printGrid(grid)
    puts
    for y in 0..grid.length-1
        for x in 0..grid[0].length-1
            print grid[y][x]
        end
        puts
    end
end

def loadClays(input)
    clays = []
    input.each do |line|
        info = line.split(",")
        if info[0][0] == 'x'
            endX = startX = info[0][2..-1].to_i
        else
            endY = startY = info[0][2..-1].to_i
        end
        info = info[1].split("..")
        if info[0][1] == 'x'
            startX = info[0][3..-1].to_i
            endX = info[1].to_i
        else
            startY = info[0][3..-1].to_i
            endY = info[1].to_i
        end

        clay = Clay.new(startX, endX, startY, endY)
        clays.push(clay)
    end

    return clays
end

def addWater(grid, x, y)
    newPoints = []

    stop = false
    grid[y][x] = '~'

    x1 = x - 1
    while x1 >= 0
        if grid[y][x1] == '#'
            break
        end
        if grid[y][x1] == '.' or grid[y][x1] == '|'
            grid[y][x1] = '~'
        end
        if grid[y+1][x1] == '|'
            stop = true
            break
        end
        if grid[y+1][x1] == '.'
            newPoints.push(Point.new(x1, y + 1))
            break
        end

        x1 -= 1
    end

    x1 = x + 1
    while x1 <= grid[y].length
        if grid[y][x1] == '#'
            break
        end
        if grid[y][x1] == '.' or grid[y][x1] == '|'
            grid[y][x1] = '~'
        end
        if grid[y+1][x1] == '|'
            stop = true
            break
        end
        if grid[y+1][x1] == '.'
            newPoints.push(Point.new(x1, y + 1))
            break
        end

        x1 += 1
    end

    if newPoints.length == 0 and stop
        return nil
    end

    return newPoints
end

def findStart(grid, x, y)
    if grid[y-1][x] == '|'
        return Point.new(x, y-1)
    end

    startX = x-1
    while grid[y][startX] == '~'
        startX -= 1
    end
    startX += 1

    endX = x+1
    while grid[y][endX] == '~'
        endX += 1
    end
    endX -= 1

    for x in startX..endX
        if grid[y-1][x] == '|'
            return Point.new(x, y-1)
        end
    end

    return nil
end

def addOverflow(grid, clays, minY)
    minY = clays.map{|clay| clay.startY}.min
    for y in minY..grid.length-1
        overflow = []
        for x in 0..grid[0].length-1
            if grid[y][x] == '#'
                overflow = []
            elsif grid[y][x] == '~'
                overflow.push(x)
            elsif grid[y][x] == '.'
                overflow.each do |x1|
                    grid[y][x1] = '|'
                end
                overflow = []
            end
        end
    end

    minY = clays.map{|clay| clay.startY}.min
    for y in minY..grid.length-1
        overflow = []
        x = grid[0].length-1
        while x >= 0
            if grid[y][x] == '#'
                overflow = []
            elsif grid[y][x] == '~'
                overflow.push(x)
            elsif grid[y][x] == '.'
                overflow.each do |x1|
                    grid[y][x1] = '|'
                end
                overflow = []
            end
            x -= 1
        end
    end
end

def reservoirResearch(input)

    clays = loadClays(input)

    minX = clays.map{|clay| clay.endX}.min - 1
    maxX = clays.map{|clay| clay.endX}.max + 1
    minY = 0
    maxY = clays.map{|clay| clay.endY}.max

    clays.each do |clay|
        clay.offset = minX
    end

    grid = []
    for y in minY..maxY
        row = Array.new((maxX-minX) + 1) { '.' }
        grid.push(row)
    end

    clays.each do |clay|
        for y in clay.startY..clay.endY
            for x in clay.startX..clay.endX
                grid[y][x] = '#'
            end
        end
    end

    step = 0

    x = 500-minX
    grid[0][x] = '+'

    points = [Point.new(x, 1)]
    while points.length > 0
        newPoints = []
        points.each do |point|
            case grid[point.y][point.x]
            when '+'
                newPoints.push(Point.new(point.x, point.y+1))
            when '.'
                grid[point.y][point.x] = '|'
                newPoints.push(Point.new(point.x, point.y+1))
            when '#'
                newPoints.push(Point.new(point.x, point.y-1))
            when '|'
                water = addWater(grid, point.x, point.y)
                if !water.nil?
                        if water.length == 0
                        newPoints.push(Point.new(point.x, point.y-1))
                    else
                        newPoints += water
                    end
                end
            when '~'
                water = addWater(grid, point.x, point.y)
                if !water.nil?
                    if water.length == 0
                        start = findStart(grid, point.x, point.y)
                        if start.nil?
                            newPoints.push(Point.new(point.x, point.y-1))
                        else
                            newPoints.push(start)
                        end
                    else
                        newPoints += water
                    end
                end
            end
        end

        completed = newPoints.select{|point| point.y > maxY}
        newPoints -= completed

        points = newPoints.uniq{|point| point.to_s}
    end

    addOverflow(grid, clays, minY)

    total = 0
    minY = clays.map{|clay| clay.startY}.min
    for y in minY..grid.length-1
        for x in 0..grid[0].length-1
            if grid[y][x] == '~'
                total += 1
            end
        end
    end

    printGrid(grid)
    return total
end