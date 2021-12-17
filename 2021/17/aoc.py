import sys

def checkVelocity(velocityX, velocityY, minX, maxX, minY, maxY):
    bestY = -sys.maxsize

    x = 0
    y = 0
    while y >= maxY:
        if x >= minX and x <= maxX:
            bestY = max(bestY, y)
            if y <= minY and y >= maxY:
                return bestY

        if velocityX != 0:
            if velocityX < 0:
                velocityX += 1
            else:
                velocityX -= 1
        velocityY -= 1

        x += velocityX
        y += velocityY

    return None

def trickShot(input):
    info = input[0].split(",")
    (minX, maxX) = map(int, info[0].split('=')[1].split('..'))
    (maxY, minY) = map(int, info[1].split('=')[1].split('..'))

    part1 = -sys.maxsize
    part2 = 0

    for y in range(maxY - 1, -(maxY - 1)):
        for x in range(0, maxX + 2):
            result = checkVelocity(x, y, minX, maxX, minY, maxY)
            if result is not None:
                part1 = max(part1, result)
                part2 += 1

    return (part1, part2)
