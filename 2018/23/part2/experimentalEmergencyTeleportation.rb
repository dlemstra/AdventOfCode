class Nanobot
    def initialize(x, y, z, radius)
        @x = x
        @y = y
        @z = z
        @radius = radius
    end
    attr_reader :x, :y, :z, :radius

    def range(other)
        if self === other
            return 0
        end

        range = distance(other.x, other.y, other.z) - @radius - other.radius
        return range < 0 ? 0 : range
    end

    def distance(x, y, z)
        return distance = (@x - x).abs + (@y - y).abs + (@z - z).abs
    end

    def distanceFromZero
        return distance(0, 0, 0) - @radius
    end
end

def removeUntilAllInRange(bots)
    sums = {}

    bots.each do |bot|
        sum = 0
        bots.each do |other|
            sum += bot.range(other)
        end
        sums[bot] = sum
    end

    i = 0
    worst, value = sums.max_by{|k,v| v}
    while value != 0
        sums.delete(worst)
        sums.each do |bot, value|
            if value != 0
                sums[bot] -= worst.range(bot)
            end
        end

        bots.delete(worst)

        worst, value = sums.max_by{|k,v| v}
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

    removeUntilAllInRange(bots)
    maxDistance = bots.map(&:distanceFromZero).max

    return maxDistance
end