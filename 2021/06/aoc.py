def lanternfish(input):
    part1 = 0

    fish = list(map(int,input[0].split(',')))
    days = 80
    while days != 0:
        new = 0
        for i in range(0, len(fish)):
            if fish[i] == 0:
                fish[i] = 6
                new += 1
            else:
                fish[i] -= 1

        for i in range(0, new):
            fish.append(8)

        days -= 1
    part1 = len(fish)

    return (part1, None)
