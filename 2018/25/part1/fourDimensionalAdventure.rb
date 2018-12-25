class Point4
    def initialize(t, x, y, z)
        @t = t
        @x = x
        @y = y
        @z = z
    end
    attr_reader :t, :x, :y, :z

    def isConnectedWith(other)
        total = (other.t - @t).abs
        return false if total > 3

        total += (other.x - @x).abs
        return false if total > 3

        total += (other.y - @y).abs
        return false if total > 3

        total += (other.z - @z).abs
        return false if total > 3

        return true
    end
end

def fourDimensionalAdventure(input)

    constellations = []

    count = 0
    input.each do |line|
        data = line.split(",").map(&:to_i)
        point = Point4.new(data[0], data[1], data[2], data[3])

        possible = []
        constellations.each_with_index do |constellation,index|
            constellation.each do |other|
                if point.isConnectedWith(other)
                    possible.push(constellation)
                    break
                end
            end
        end

        if possible.length == 0
            constellations.push([point])
        else
            possible[0].push(point)
            while possible.length != 1
                constellation = possible.pop
                possible[0].concat(constellation)
                constellations.delete(constellation)
            end
        end
    end

    return constellations.count
end