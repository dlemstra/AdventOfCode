class Cart
    def initialize(x, y, direction)
        @x = x
        @y = y
        @state = 0
        @crashed = false

        case direction
        when "^"
            @xStep = 0
            @yStep = -1
        when ">"
            @xStep = 1
            @yStep = 0
        when "v"
            @xStep = 0
            @yStep = 1
        when "<"
            @xStep = -1
            @yStep = 0
        end
    end
    attr_reader :x, :y, :crashed
    attr_writer :crashed

    def move(corners, intersections)
        if @crashed
            return false
        end

        pos = "#{@x},#{@y}"
        if intersections[pos] != 0
            takeIntersection
        else
            corner = corners[pos]
            if corner != 0
                takeCorner(corner)
            end
        end

        @x += @xStep
        @y += @yStep
        return true
    end

    def info
        return "#{@x},#{@y} #{@xStep} #{@yStep}"
    end

    def to_s
        return "#{@x},#{@y}"
    end

    private

    def takeIntersection
        case @state
        when 0 # left
            if @xStep == 0
                @xStep = @yStep
                @yStep = 0
            else
                @yStep = @xStep * -1
                @xStep = 0
            end
            @state = 1
        when 1 # straight
            @state = 2
        when 2 # right
            if @xStep == 0
                @xStep = @yStep * -1
                @yStep = 0
            else
                @yStep = @xStep
                @xStep = 0
            end
            @state = 0
        end
    end

    def takeCorner(corner)
        if corner == '/'
            if @xStep == 0
                @xStep = @yStep * -1
                @yStep = 0
            else
                @yStep = @xStep * -1
                @xStep = 0
            end
        else # \
            if @xStep == 0
                @xStep = @yStep
                @yStep = 0
            else
                @yStep = @xStep
                @xStep = 0
            end
        end
    end
end

def checkCollision(cart, carts)
    carts.each do |other|
        if other.crashed
            next
        end

        if cart != other
            if cart.x == other.x and cart.y == other.y
                cart.crashed = true
                other.crashed = true
                return true
            end
        end
    end

    return false
end

def mineCartMadness(input)
    carts = []
    corners = Hash.new() { 0 }
    intersections = Hash.new() { 0 }
    y = 0
    input.each do |line|
        x = 0
        line.chars.each do |char|
            pos = "#{x},#{y}"
            case char
            when '/'
                corners[pos] = char
            when '\\'
                corners[pos] = char
            when '+'
                intersections[pos] = 1
            when '^'
                carts.push(Cart.new(x, y, char))
            when '>'
                carts.push(Cart.new(x, y, char))
            when 'v'
                carts.push(Cart.new(x, y, char))
            when '<'
                carts.push(Cart.new(x, y, char))
            end
            x += 1
        end
        y += 1
    end

    while carts.length > 1
        carts = carts.sort_by{|cart| "#{cart.y.to_s.rjust(3, '0')}x#{cart.x.to_s.rjust(3, '0')}"}

        carts.each do |cart|
            if cart.move(corners, intersections)
                checkCollision(cart, carts)
            end
        end

        carts = carts.select{|cart| !cart.crashed}
    end

    return carts[0].to_s
end