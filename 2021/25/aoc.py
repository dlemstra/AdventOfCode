def readMap(input):
    result = []
    for line in input:
        result.append(list(line))

    return result

def moveMap(map):
    height = len(map)
    width = len(map[0])

    newMap = []
    for _ in range(0, height):
        newMap.append(list('.' * width))

    moved = False

    for y in range(0, height):
        for x in range(0, width):
            if map[y][x] == '>':
                nextX = (x + 1) % width
                if map[y][nextX] == '.':
                    moved = True
                    newMap[y][nextX] = '>'
                else:
                    newMap[y][x] = '>'

    for y in range(0, height):
        for x in range(0, width):
            if map[y][x] == 'v':
                nextY = (y + 1) % height
                if newMap[nextY][x] == '.' and map[nextY][x] != 'v':
                    moved = True
                    newMap[nextY][x] = 'v'
                else:
                    newMap[y][x] = 'v'

    return newMap if moved else None

def seaCucumber(input):
    map = readMap(input)

    map = moveMap(map)
    part1 = 1
    while map != None:
        map = moveMap(map)
        part1 += 1

    return part1
