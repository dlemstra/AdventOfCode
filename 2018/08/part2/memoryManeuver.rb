def metaDataSum(data)
    child_count = data.shift
    metadata_count = data.shift

    if child_count == 0
        return data.shift(metadata_count).sum
    end

    children = Array.new(child_count)
    for i in 0..child_count - 1 do
        children[i] = metaDataSum(data)
    end

    sum = 0
    data.shift(metadata_count).each do |offset|
        if offset <= child_count
            sum += children[offset - 1]
        end
    end

    return sum
end

def memoryManeuver(input)
    data = input.map(&:to_i)

    return metaDataSum(data)
end