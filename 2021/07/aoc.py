import sys

def theTreacheryOfWhales(input):
    crabs = list(map(int,input[0].split(',')))

    part1 = sys.maxsize
    for i in range(0, len(crabs)):
        total = 0
        for j in range(0, len(crabs)):
            if i == j: continue
            total += abs(crabs[i]-crabs[j])
        part1 = min(part1, total)

    part2 = sys.maxsize
    for i in range(0, len(crabs)):
        total = 0
        for j in range(0, len(crabs)):
            distance = abs(i-crabs[j])
            total += ((distance + 1) * 0.5) * distance
        part2 = min(part2, int(total))

    return (part1, part2)
