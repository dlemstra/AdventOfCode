def extendedPolymerization(input):
    value = list(input[0])
    pairs = []
    for i in range(2, len(input)):
        pair = input[i].split(' -> ')
        pairs.append(pair)

    for i in range(0, 10):
        j=0
        while j < len(value) - 1:
            for pair in pairs:
                if value[j] == pair[0][0] and value[j + 1] == pair[0][1]:
                    value.insert(j + 1, pair[1])
                    j += 2
                    break

    counts = {}
    for c in value:
        if not c in counts:
            counts[c] = 0
        counts[c] += 1
    mostCommon = counts[max(counts, key=counts.get)]
    leastCommon = counts[min(counts, key=counts.get)]

    part1 = mostCommon - leastCommon

    return (part1, None)
