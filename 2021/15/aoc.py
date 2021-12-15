class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __str__(self):
        return f"{self.x}x{self.y}"

class State:
    def __init__(self, point, score):
        self.point = point
        self.score = score

def neighbours(point, width, height):
    for (x, y) in [(point.x - 1, point.y), (point.x + 1, point.y), (point.x, point.y - 1), (point.x, point.y + 1)]:
        if (x >=0 and x < width and y >= 0 and y < height):
            yield Point(x, y)

def readMaze(input):
    maze = []
    for line in input:
        maze.append(list(map(int,list(line))))

    return maze

def getRisk(maze):
    height = len(maze)
    width = len(maze[0])

    risk = {}
    risk["0x0"] = 0
    start = State(Point(0, 0), 0)
    stack = [start]

    while len(stack) > 0:
        state = stack.pop(0)
        point = state.point

        if risk[str(point)] < state.score:
            continue

        if point.x == width - 1 and point.y == height - 1:
            continue

        for neighbour in neighbours(point, width, height):
            score = state.score + maze[neighbour.y][neighbour.x]
            position = str(neighbour)
            if position not in risk or risk[position] > score:
                risk[position] = score
                stack.append(State(neighbour, score))

    return risk[f"{width - 1}x{height - 1}"]

def extentMaze(maze):
    height = len(maze)
    width = len(maze[0])

    for i in range(1, 5):
        for y in range(0, height):
            row = []
            for x in range(0, width):
                score = maze[y][x] + i
                if score > 9:
                    score -= 9
                row.append(score)
            maze.append(row)

    height = len(maze)
    for y in range(0, height):
        for i in range(1, 5):
            for x in range(0, width):
                score = maze[y][x] + i
                if score > 9:
                    score -= 9
                maze[y].append(score)

    return maze

def chiton(input):
    maze = readMaze(input)
    part1 = getRisk(maze)

    maze = extentMaze(maze)
    part2 = getRisk(maze)

    return (part1, part2)
