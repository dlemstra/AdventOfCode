def reactorReboot(input):
    part1 = 0

    states = {}
    for line in input:
        info = line.split(' ')
        state = info[0]
        info = info[1].split(',')
        (startX, endX) = map(int,info[0].split('=')[1].split('..'))
        (startY, endY) = map(int,info[1].split('=')[1].split('..'))
        (startZ, endZ) = map(int,info[2].split('=')[1].split('..'))
        for z in range(startZ, endZ + 1):
            if z < -50 or z > 50: continue
            for y in range(startY, endY + 1):
                if y < -50 or y > 50: continue
                for x in range(startX, endX + 1):
                    if x < -50 or x > 50: continue
                    states[f"{x},{y},{z}"] = 1 if state == 'on' else 0

    part1 = len(list(filter(lambda elem: elem[1] == 1, states.items())))

    return (part1, None)
