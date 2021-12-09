def neighbours(x, y, width, height):
    if x - 1 >= 0:
        yield (x - 1, y)
    if x + 1 < width:
        yield (x + 1, y)
    if y - 1 >= 0:
        yield (x, y - 1)
    if y + 1 < height:
        yield(x, y + 1)

def findBasin(grid, width, height, x, y):
    if grid[y][x] == '.' or grid[y][x] == '9':
        return 0

    grid[y][x] = '.'
    count = 1
    for (x1, y1) in neighbours(x, y, width, height):
        count += findBasin(grid, width, height, x1, y1)

    return count

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

    counts = []
    for y in range(0, height):
        for x in range(0, width):
            count = findBasin(grid, width, height, x, y)
            if count != 0:
                counts.append(count)

    part2 = 1
    for count in sorted(counts)[-3:]:
        part2 *= count

    return (part1, part2)
