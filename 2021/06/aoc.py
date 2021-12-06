def countFish(fish, days):
    counts = [0] * 9
    for f in fish:
        counts[f] += 1

    day = 0
    while day < days:
        count0 = counts[0]
        for i in range(0, len(counts) - 1):
            counts[i] = counts[i + 1]
        counts[6] += count0
        counts[8] = count0
        day += 1

    return sum(counts)


def lanternfish(input):
    fish = list(map(int,input[0].split(',')))

    part1 = countFish(fish, 80)
    part2 = countFish(fish, 256)

    return (part1, part2)
