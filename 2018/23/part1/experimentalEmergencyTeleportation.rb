class Nanobot
    def initialize(x, y, z, radius)
        @x = x
        @y = y
        @z = z
        @radius = radius
    end
    attr_reader :x, :y, :z, :radius

    def inRange(other)
        return distance(other) <= @radius
    end

    def distance(other)
        return (@x - other.x).abs + (@y - other.y).abs + (@z - other.z).abs
    end

    def to_s
        return "pos=<#{@x},#{@y},#{@z}>, r=#{@radius}"
    end
end

def experimentalEmergencyTeleportation(input)
    bots = []

    input.each do |line|
        info = line.split(",")
        x = info[0][5..-1].to_i
        y = info[1].to_i
        z = info[2][0..-2].to_i
        radius = info[3][3..-1].to_i

        bots.push(Nanobot.new(x, y, z, radius))
    end

    strongest = bots.max_by(&:radius)

    total = 0
    bots.each do |bot|
        if strongest.inRange(bot)
            total += 1
        end
    end

    return total
end