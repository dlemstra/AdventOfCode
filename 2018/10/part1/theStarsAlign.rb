class Dot
    def initialize(x, y, velocityX, velocityY)
        @x = x
        @y = y
        @velocityX = velocityX
        @velocityY = velocityY
    end
    attr_reader :x, :y

    def isConnected(other)
        if other == self
            return false
        end

        if @x == other.x
            return (@y == other.y-1 or @y == other.y+1)
        elsif @y == other.y
            return (@x == other.x-1 or @x == other.x+1)
        end

        return distance(other) == 2
    end

    def distance(other)
        return (other.x - @x).abs + (other.y - @y).abs
    end

    def move(speed = 1)
        @x += @velocityX * speed
        @y += @velocityY * speed
    end

    def to_s
        return "#{@x}x#{@y} (#{@velocityX},#{@velocityY})"
    end
end

def printDots(dots)
    xCoords = dots.map(&:x)
    yCoords = dots.map(&:y)
    minX = xCoords.min
    maxX = xCoords.max
    minY = yCoords.min
    maxY = yCoords.max

    for y in minY..maxY
        row = []
        for x in minX..maxX
            found = false
            dots.each do |dot|
                if dot.x == x and dot.y == y
                    found = true
                    break
                end
            end
            row.push( found ? "#" : ".")
        end
        puts row.join
    end
end

def allConnected(dots)
    for i in 0..dots.length-1 do
        found = false
        for j in 0..dots.length-1 do
            if dots[i].isConnected(dots[j])
                found = true
                break
            end
        end
        if !found
            return false
        end
    end

    return true
end

def maxDistance(dots)
    max = 0 
    for i in 0..dots.length
        for j in i+1..dots.length-1 do
            distance = dots[i].distance(dots[j])
            if distance > max
                max = distance
            end
        end
    end

    return max
end

def theStarsAlign(input)
    dots = []
    input.each do |line|
        info = line.split(",")
        x = info[0].split("<")[1].to_i
        y = info[1].split(">")[0].to_i
        velocityX = info[1].split("<")[1].to_i
        velocityY = info[2].split(">")[0].to_i
        dots.push(Dot.new(x, y, velocityX, velocityY))
    end

    max = maxDistance(dots)
    while max > 200
        speed = max / 100
        dots.each{|dot| dot.move(speed)}
        max = maxDistance(dots)
    end

    while !allConnected(dots)
        dots.each{|dot| dot.move}
    end

    printDots(dots)

    return maxDistance(dots)
end