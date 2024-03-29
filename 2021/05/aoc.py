class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __str__(self):
        return f"{self.x}x{self.y}"

class Line:
    def __init__(self, source, target):
        self.source = source
        self.target = target

    def validForPart1(self):
        return self.source.x == self.target.x or self.source.y == self.target.y

    def coveredPoints(self):
        if self.source.x == self.target.x:
            start = min(self.source.y, self.target.y)
            end = max(self.source.y, self.target.y)
            for y in range(start, end + 1):
                yield Point(self.source.x, y)
        elif self.source.y == self.target.y:
            start = min(self.source.x, self.target.x)
            end = max(self.source.x, self.target.x)
            for x in range(start, end + 1):
                yield Point(x, self.source.y)
        else:
            x = self.source.x
            y = self.source.y
            incrementX = x < self.target.x
            incrementY = y < self.target.y
            while x != self.target.x:
                yield Point(x, y)
                if incrementX:
                    x += 1
                else:
                    x -= 1
                if incrementY:
                    y += 1
                else:
                    y -= 1
            yield Point(x, y)

def updatePoints(points, point):
    key = str(point)
    value = points.get(key, 0)
    points[key] = value + 1

def hydrothermalVenture(input):
    part1 = 0

    lines = []
    for line in input:
        info = line.split(' -> ')
        (x1, y1) = info[0].split(',')
        (x2, y2) = info[1].split(',')
        lines.append(Line(Point(int(x1), int(y1)), Point(int(x2), int(y2))))

    valid_lines = list(filter(lambda line: line.validForPart1(), lines))

    points = {}
    for valid_line in valid_lines:
        for point in valid_line.coveredPoints():
            updatePoints(points, point)

    part1 = sum(1 for _ in filter(lambda key: points[key] > 1, points))

    points = {}
    for line in lines:
        for point in line.coveredPoints():
            updatePoints(points, point)

    part2 = sum(1 for _ in filter(lambda key: points[key] > 1, points))

    return (part1, part2)
