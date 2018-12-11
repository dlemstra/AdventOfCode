def powerLevel(x, y, serial)
    rackId = x + 10
    powerLevel = rackId * y
    powerLevel += serial
    powerLevel *= rackId
    hunderd = powerLevel.to_s[-3].to_i
    return hunderd - 5
end

def gridValue(x, y, value, serial)

    total = 0
    for y1 in 0..2
        for x1 in 0..2
            if x == 0 and y == 0
                val = value
            else
                val = powerLevel(x + x1, y + y1, serial)
                if val < 0
                    return -1
                end
            end
            total += val
        end
    end

    return total
end

def chronalCharge(serial)

    totals = {}

    width = 300
    for y in 0..width
        for x in 0..width
            val = powerLevel(x, y, serial)
            if val > 0
                total = gridValue(x, y, val, serial)
                if total != -1
                    totals["#{x},#{y}"] = total
                end
            end
        end
    end

    return totals.key(totals.values.max)
end