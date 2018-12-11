def powerLevel(x, y, serial)
    if x == y || y  == 0
        return 0
    end
    rackId = x + 10
    powerLevel = rackId * y
    powerLevel += serial
    powerLevel *= rackId
    hunderd = powerLevel.to_s[-3].to_i
    return hunderd - 5
end

def chronalCharge(serial)

    totals = {}

    size = 300
    grid = Array.new(size){Array.new(size) { 0 }}
    for y in 1..size-1
        for x in 1..size-1
            val = powerLevel(x, y, serial)
            val += grid[y][x-1]
            val += grid[y-1][x]
            val -= grid[y-1][x-1]
            grid[y][x] = val
        end
    end

    max = 0
    maxPos = ""
    for y in 1..size-4
        for x in 1..size-4
            y0 = y - 1
            x0 = x - 1
            y1 = y + 2
            x1 = x + 2

            while y1 < size-1 and x1 < size-1
                y1 += 1
                x1 += 1
            
                total = grid[y0][x0] + grid[y1][x1] - grid[y0][x1] - grid[y1][x0]
                if total > max
                    max = total
                    maxPos = "#{x},#{y},#{x1-x+1}"
                end
            end
        end
    end

    return maxPos
end