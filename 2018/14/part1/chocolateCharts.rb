def chocolateCharts(input)
    items = [3, 7]

    first = 0
    second = 1

    while items.length != input+10
        firstValue = items[first]
        secondValue = items[second]

        value = firstValue + secondValue
        if value >= 10
            items.push(value / 10)
            if items.length != input+10
                items.push(value % 10)
            end
        else
            items.push(value)
        end

        first = (first + firstValue + 1) % items.length
        second = (second +secondValue + 1) % items.length
    end

    return items[-10..-1].join()
end