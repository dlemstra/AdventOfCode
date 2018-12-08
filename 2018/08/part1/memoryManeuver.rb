def metaDataSum(data)
    child_count = data.shift
    metadata_count = data.shift

    sum = 0
    for i in 0..child_count - 1 do
        sum += metaDataSum(data)
    end

    return sum + data.shift(metadata_count).sum
end

def memoryManeuver(input)
    data = input.map(&:to_i)

    return metaDataSum(data)
end