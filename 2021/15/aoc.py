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

def chiton(input):
    part1 = 0

    maze = readMaze(input)
    height = len(maze)
    width = len(maze[0])

    risk = {}

    start = State(Point(0, 0), 0)
    stack = [start]

    while len(stack) > 0:
        state = stack.pop(0)
        point = state.point

        if point.x == width - 1 and point.y == height - 1:
            continue

        for neighbour in neighbours(point, width, height):
            score = state.score + maze[neighbour.y][neighbour.x]
            position = str(neighbour)
            if position not in risk or risk[position] > score:
                risk[position] = score
                stack.append(State(neighbour, score))

    part1 = risk[f"{width - 1}x{height - 1}"]

    return (part1, None)
