def setErosionLevel(erosions, depth, x, y)
    if y == 0
        result = ((x * 16807) + depth) % 20183
    elsif x == 0
        result = ((y * 48271) + depth) % 20183
    else
        result = ((erosions["#{x-1}x#{y}"] * erosions["#{x}x#{y-1}"]) + depth) % 20183
    end

    erosions["#{x}x#{y}"] = result
end

def modeMaze(input)
    depth = input[0].split(" ")[1].to_i
    targetX, targetY = input[1][8..-1].split(",").map(&:to_i)

    erosions= {}
    for y in 0..targetY
        for x in 0..targetX
            if y == targetY and x == targetX
                erosions["#{x}x#{y}"] = erosions["0x0"]
            else
                setErosionLevel(erosions, depth, x, y)
            end
        end
    end

    total = 0
    erosions.values.each do |value|
        total += value % 3
    end

    return total
end