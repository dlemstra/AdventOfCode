def neighbours(x, y, width, height):
    for (x, y) in [(x-1, y-1), (x, y-1), (x+1, y-1), (x-1, y), (x+1, y), (x-1, y+1), (x, y+1), (x+1, y+1)]:
        if (x >=0 and x < width and y >= 0 and y < height):
            yield (x, y)

def incrementGrid(grid, width, height):
    for y in range(0, height):
        for x in range(0, width):
            grid[y][x] += 1

def flashGrid(grid, width, height):
    flashes = 0
    for y in range(0, height):
        for x in range(0, width):
            if grid[y][x] > 9:
                flashes += 1
                grid[y][x] = 0
                for (x1, y1) in neighbours(x, y, width, height):
                    if grid[y1][x1] != 0:
                        grid[y1][x1] += 1
    return flashes

def dumboOctopus(input):
    grid = []
    for line in input:
        grid.append(list(map(int,list(line))))
    width = len(grid[0])
    height = len(grid)

    part1 = 0
    for _ in range(0, 100):
        incrementGrid(grid, width, height)
        count = flashGrid(grid, width, height)
        part1 += count
        while count > 0:
            count = flashGrid(grid, width, height)
            part1 += count

    return (part1, None)
