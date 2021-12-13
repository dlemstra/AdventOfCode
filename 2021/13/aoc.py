class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

def fold(points, part, position):
    newPoints = []

    if part == 'y':
        for point in points:
            if point.y < position:
                newPoints.append(point)

        for point in points:
            if point.y > position:
                y = position - (point.y - position)
                newPoint = Point(point.x, y)
                if newPoint not in newPoints:
                    newPoints.append(newPoint)
    elif part == 'x':
        for point in points:
            if point.x < position:
                newPoints.append(point)

        for point in points:
            if point.x > position:
                x = position - (point.x - position)
                newPoint = Point(x, point.y)
                if newPoint not in newPoints:
                    newPoints.append(newPoint)

    return newPoints

def passagePathing(input):

    points = []
    for i in range(0, len(input)):
        line = input[i]
        if line == '':
            break
        (x, y) = line.split(',')
        points.append(Point(int(x), int(y)))

    (part, position) = input[i + 1].split(' ')[2].split('=')
    points = fold(points, part, int(position))

    part1 = len(points)

    for j in range(i + 2, len(input)):
        (part, position) = input[j].split(' ')[2].split('=')
        points = fold(points, part, int(position))

    maxX = 0
    maxY = 0
    for point in points:
        maxX = max(point.x, maxX)
        maxY = max(point.y, maxY)

    part2 = '\n'
    for y in range(0, maxY + 1):
        for x in range(0, maxX + 1):
            if Point(x, y) in points:
                part2 += '#'
            else:
                part2 += ' '
        part2 += '\n'

    return (part1, part2)
