def matches(input, match)
    index = input.length - 1

    for i in 0..match.length-1
        if match[i] != input[index-i]
            return -1
        end
    end

    return index - match.length + 1
end

def chocolateCharts(input)
    items = [3, 7]

    first = 0
    second = 1

    reverseInput = input.reverse

    index = -1
    while index == -1
        firstValue = items[first]
        secondValue = items[second]

        value = firstValue + secondValue
        if value >= 10
            items.push(value / 10)
            index = matches(items, reverseInput)
            if index == -1
                items.push(value % 10)
                index = matches(items, reverseInput)
            end
        else
            items.push(value)
            index = matches(items, reverseInput)
        end

        first = (first + firstValue + 1) % items.length
        second = (second +secondValue + 1) % items.length
    end

    return index
end