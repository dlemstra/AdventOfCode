def neighbours(x, y, width, height):
    if x - 1 >= 0:
        yield (x - 1, y)
    if x + 1 < width:
        yield (x + 1, y)
    if y - 1 >= 0:
        yield (x, y - 1)
    if y + 1 < height:
        yield(x, y + 1)

def smokeBasin(input):
    grid = []
    for line in input:
        grid.append(list(line))
    width = len(grid[0])
    height = len(grid)

    part1 = 0
    for y in range(0, height):
        for x in range(0, width):
            value = grid[y][x]
            isLow = True
            for (x1, y1) in neighbours(x, y, width, height):
                if grid[y1][x1] <= value:
                    isLow = False
                    break
            if isLow:
                part1 += int(value) + 1

    return (part1, None)
