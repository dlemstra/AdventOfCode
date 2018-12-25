class Point4
    def initialize(t, x, y, z)
        @t = t
        @x = x
        @y = y
        @z = z
    end
    attr_reader :t, :x, :y, :z

    def isConnectedWith(other)
        return ((other.t - @t).abs + (other.x - @x).abs + (other.y - @y).abs + (other.z - @z).abs) <= 3
    end
end

def fourDimensionalAdventure(input)

    constellations = []

    count = 0
    prev = nil
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
            possible[0].insert(0, point)
            if possible.length > 1
                possible[1..-1].each do |constellation|
                    while constellation.length > 0
                        possible[0].insert(0, constellation.shift)
                    end
                end
            end
        end
    end

    return constellations.select{|constellation| constellation.count > 0}.count
end