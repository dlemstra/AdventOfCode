class Pair:
    def __init__(self, key, replacement):
        self.key = key
        self.replacements = [key[0] + replacement[0], replacement[0] + key[1]]

def executeSteps(counts, pairs, steps):
    for _ in range(0, steps):
        newCounts = counts.copy()
        for pair in pairs:
            if pair.key in counts:
                count = counts[pair.key]
                for replacement in pair.replacements:
                    if not replacement in newCounts:
                        newCounts[replacement] = 0
                    newCounts[replacement] += count

                newCounts[pair.key] -= count
        counts = newCounts

    return counts

def getTotal(counts, value):
    totals = {}
    for key in counts:
        count = counts[key]
        if key[0] not in totals:
            totals[key[0]] = 0
        totals[key[0]] += count

    totals[value[-1:]] += 1
    mostCommon = totals[max(totals, key=totals.get)]
    leastCommon = totals[min(totals, key=totals.get)]

    return mostCommon - leastCommon

def extendedPolymerization(input):
    pairs = []
    for i in range(2, len(input)):
        pair = input[i].split(' -> ')
        pairs.append(Pair(pair[0], pair[1]))

    counts = {}

    value = input[0]
    for i in range(0, len(value) - 1):
        key = value[i:i+2]
        if key not in counts:
            counts[key] = 0
        counts[key] += 1

    counts = executeSteps(counts, pairs, 10)
    part1 = getTotal(counts, value)

    counts = executeSteps(counts, pairs, 30)
    part2 = getTotal(counts, value)

    return (part1, part2)
