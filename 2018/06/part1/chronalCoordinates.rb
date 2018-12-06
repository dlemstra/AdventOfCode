class Position
    def initialize(x, y)
        @x = x
        @y = y
    end
    attr_reader :x, :y

    def distance(x, y)
        return (x - @x).abs + (y - @y).abs
    end

    def to_s
        return "#{@x}x#{@y}"
    end
end

def chronalCoordinates(input)

    coords = []
    input.each do |line|
        info = line.split(",")
        pos = Position.new(info[0].to_i, info[1].to_i)
        coords.push(pos)
    end

    minX = coords[0].x
    maxX = coords[0].x
    minY = coords[0].y
    maxY = coords[0].y
    coords.each do |pos|
        if pos.x < minX
            minX = pos.x
        end
        if pos.x > maxX
            maxX = pos.x
        end
        if pos.y < minY
            minY = pos.y
        end
        if pos.y > maxY
            maxY = pos.y
        end
    end

    result = Hash.new(0)
    for y in minY..maxY do
        for x in minX..maxX do

            min = nil
            minDistance = 0
            duplicate = false

            coords.each do |pos|
                if pos.x == x and pos.y == y
                    min = pos
                    break
                end

                distance = pos.distance(x, y)
                if min.nil? or distance < minDistance
                    min = pos
                    minDistance = distance
                    duplicate = false
                elsif distance == minDistance
                    duplicate = true
                end
            end

            if !min.nil? and !duplicate and result[min.to_s] != -1
                if x == minX or y == minY or x == maxX or y == maxY
                    result[min.to_s] = -1
                else
                    result[min.to_s] += 1
                end
            end
        end
    end

    return result.max_by{|k,v| v}[1]
end