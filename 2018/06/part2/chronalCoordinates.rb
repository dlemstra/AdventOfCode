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

def chronalCoordinates(maxSum, input)

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

    count = 0
    for y in minY..maxY do
        for x in minX..maxX do
            distanceSum = maxSum
            coords.each do |pos|
                distanceSum -= pos.distance(x, y)
                if distanceSum < 0
                    break
                end
            end

            if distanceSum > 0
                count += 1
            end
        end
    end

    return count
end