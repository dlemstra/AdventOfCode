class Area
    def initialize(x, y, width, height)
        @x = x
        @y = y
        @maxX = x + width - 1
        @maxY = y + height - 1
    end
    attr_reader :x, :y, :maxX, :maxY

    def intersects(other)
        if maxX < other.x or x > other.maxX
            return false
        end
        if maxY < other.y or y > other.maxY
            return false
        end

        return true
    end

    def intersectingCoords(other)
        areaX = [x, other.x].max
        areaY = [y, other.y].max
        areaMaxX = [maxX, other.maxX].min
        areaMaxY = [maxY, other.maxY].min

        result = []
        for x in areaX..areaMaxX
            for y in areaY..areaMaxY
                result.push("#{x}x#{y}")
            end
        end

        return result
    end

    def to_s()
        return "#{@x}x#{@y} #{@width},#{@height}"
    end
end

def findIntersectingCoords(areas)
    result = {}
    for i in 0..areas.length-1
        for j in i+1..areas.length-1
            if areas[i].intersects(areas[j])
                areas[i].intersectingCoords(areas[j]).each do |pos|
                    result[pos] = 1
                end
            end
        end
    end

    return result
end

def noMatterHowYouSliceIt(input)
    areas = []
    input.each do |str|
        info = str.split
        offset = info[2][0..-2].split(",").map(&:to_i)
        size = info[3].split("x").map(&:to_i)
        areas.push(Area.new(offset[0], offset[1], size[0], size[1]))
    end

    intersecting = findIntersectingCoords(areas)

    return intersecting.length
end