def findIndex(a, b)
    index = -1
    for i in 1..a.length-1
        if a[i] != b[i]
            if index != -1
                return -1
            end
            index = i
        end
    end

    return index
end

def inventoryManagementSystem(input)
    sorted = input.sort

    for i in 1..sorted.length-1
        index = findIndex(sorted[i], sorted[i-1])
        if index != -1
            sorted[i].slice!(index)
            return sorted[i]
        end
    end
    return "?"
end