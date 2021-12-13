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
    position = int(position)

    points = fold(points, part, position)
    part1 = len(points)

    return (part1, None)
