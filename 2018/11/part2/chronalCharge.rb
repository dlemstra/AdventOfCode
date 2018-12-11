def powerLevel(x, y, serial)
    rackId = x + 10
    powerLevel = rackId * y
    powerLevel += serial
    powerLevel *= rackId
    hunderd = powerLevel.to_s[-3].to_i
    return hunderd - 5
end

def chronalCharge(serial)

    totals = {}

    width = 300
    grid = []
    for y in 0..width-1
        row = []
        for x in 0..width-1
            val = powerLevel(x, y, serial)
            row.push(val)
        end
        grid.push(row)
    end

    max = 0
    maxPos = ""
    minSize = 3
    for y in 0..width-1
        for x in 0..width-1
            if x + minSize == width + 1
                break
            end

            total = 0
            for i in 0..minSize-1
                for j in 0..minSize-1
                    total += grid[y+i][x+j]
                end
            end

            if total > max
                max = total
                maxPos = "#{x},#{y}"
            end

            start = [x,y].max

            for step in minSize..width-start-1
                for i in 0..step-1
                    total += grid[y+i][x+step]
                    total += grid[y+step][x+i]
                end

                total += grid[y+step][x+step]

                if total > max
                    max = total
                    maxPos = "#{x},#{y},#{step+1}"
                end
            end
        end

        if y + minSize == width
            break
        end
    end

    return maxPos
end
