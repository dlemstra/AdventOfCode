class Area
    def initialize(id, x, y, width, height)
        @id = id
        @x = x
        @y = y
        @width = width
        @height = height
    end

    def id()
        @id
    end

    def x()
        @x
    end

    def y()
        @y
    end

    def maxX
        @x + @width - 1
    end

    def maxY
        @y + @height - 1
    end

    def intersects(other)
        if maxX < other.x or x > other.maxX
            return false
        end
        if maxY < other.y or y > other.maxY
            return false
        end

        return true
    end

    def to_s()
        return "#{@x}x#{@y} #{@width},#{@height}"
    end
end

def noMatterHowYouSliceIt(input)
    areas = []
    input.each do |str|
        info = str.split
        offset = info[2][0..-2].split(",").map(&:to_i)
        size = info[3].split("x").map(&:to_i)
        areas.push(Area.new(info[0], offset[0], offset[1], size[0], size[1]))
    end

    for i in 0..areas.length-1
        found = false
        for j in 0..areas.length-1
            if areas[i].id != areas[j].id and areas[i].intersects(areas[j])
                found = true
                break
            end
        end

        if found == false
            return areas[i].id
        end
    end

    return -1
end