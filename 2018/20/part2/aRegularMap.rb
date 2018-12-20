class QueueNode
    def initialize(point, previous, door)
        @point = point
        @distance = 0
        @doors = door

        if !previous.nil?
            @distance = previous.distance + 1
            @doors += previous.doors
        end
    end
    attr_reader :point, :distance, :doors

    def to_s
        return "distance = #{distance}, doors = #{doors}, point = #{point.x}x#{point.y}"
    end
end

class Point
    def initialize(x, y)
        @x = x
        @y = y
    end
    attr_reader :x, :y

    def to_s
        return "#{x}x#{y}"
    end
end

def breadthFirstSearch(grid, src, dst)
    visited = Hash.new(0)
    visited[src.to_s] = 1

    colNum = [-1,  0, 0, 1]
    rowNum = [ 0, -1, 1, 0]

    queue = Array.new
    start = QueueNode.new(src, nil, 0)
    queue.push(start)

    while queue.size != 0
        current = queue.first
        point = current.point

        if point.x == dst.x and point.y == dst.y
            return current
        end

        queue.shift

        for i in 0..3
            x = point.x + rowNum[i]
            y = point.y + colNum[i]

            pos = Point.new(x, y)
            if (grid[y][x] == '.' or grid[y][x] == '|' or grid[y][x] == '?' or grid[y][x] == '-') and visited[pos.to_s] == 0
                visited[pos.to_s] = 1

                cell = QueueNode.new(pos, current, (grid[y][x] == '|' or grid[y][x] == '-') ? 1 : 0)
                queue.push(cell)
            end
        end
    end

    return nil
end

class Point
    def initialize(x, y)
        @x = x
        @y = y
    end
    attr_reader :x, :y

    def to_s
        return "#{x}x#{y}"
    end
end

def setPoint(map, x, y, char)
    if map["#{x}x#{y}"] == 0
        map["#{x}x#{y}"] = char
    end

    map["#{x-1}x#{y-1}"] = '#'
    if map["#{x-1}x#{y}"] == 0
        map["#{x-1}x#{y}"] = '?'
    end

    map["#{x-1}x#{y+1}"] = '#'
    if map["#{x}x#{y+1}"] == 0
        map["#{x}x#{y+1}"] = '?'
    end

    map["#{x+1}x#{y-1}"] = '#'
    if map["#{x}x#{y-1}"] == 0
        map["#{x}x#{y-1}"] = '?'
    end

    map["#{x+1}x#{y+1}"] = '#'
    if map["#{x+1}x#{y}"] == 0
        map["#{x+1}x#{y}"] = '?'
    end
end

def updateMap(map, x, y, char)
    case char
    when 'N'
        map["#{x}x#{y-1}"] = '-'
        y -= 2
        setPoint(map, x, y, '.')
    when 'E'
        map["#{x+1}x#{y}"] = '|'
        x += 2
        setPoint(map, x, y, '.')
    when 'S'
        map["#{x}x#{y+1}"] = '-'
        y += 2
        setPoint(map, x, y, '.')
    when 'W'
        map["#{x-1}x#{y}"] = '|'
        x -= 2
        setPoint(map, x, y, '.')
    when 'X'
        setPoint(map, x, y, 'X')
    end

    return Point.new(x, y)
end

def parseRegex(input)
    map = Hash.new(0)

    previous = []

    point = updateMap(map, 0, 0, 'X')
    input.chars.each do |char|
        case char
        when 'N', 'E', 'S', 'W'
            point = updateMap(map, point.x, point.y, char)
        when '('
            previous.push(point)
        when ')'
            point = previous.pop
        when '|'
            point = previous[-1]
        end
    end

    map.select{|k,v| v == '?' }.each do |k,v|
        map[k] = '#'
    end

    return map
end

def createGrid(map)
    coords = map.keys.map{|xy|xy.split('x')}
    xCoords = coords.map{|xy|xy[0].to_i}
    yCoords = coords.map{|xy|xy[1].to_i}

    minY = yCoords.min
    maxY = yCoords.max
    minX = xCoords.min
    maxX = xCoords.max

    grid = []
    for y in minY..maxY
        row = []
        for x in minX..maxX
            char = map["#{x}x#{y}"]
            row.push(char == 0 ? ' ' : char)
        end
        grid.push(row)
    end

    return grid
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

def findStart(grid)
    for y in 0..grid.length-1
        for x in 0..grid[0].length-1
            if grid[y][x] == 'X'
                return Point.new(x, y)
            end
        end
    end
end

def aRegularMap(input)

    map = parseRegex(input)

    grid = createGrid(map)

    count = 0
    src = findStart(grid)

    destinations = []
    for y in 1.step(grid.length - 2, 2)
        for x in 1.step(grid.length - 2, 2)
            destinations.push(Point.new(x, y))
        end
    end

    while destinations.length > 0
       dst = destinations.shift
       result = breadthFirstSearch(grid, src, dst)
       if result.doors >= 1000
           STDERR.puts "#{result} remaining=#{destinations.length}"
           count +=1
       end
    end

    printGrid(grid)

    return count
end