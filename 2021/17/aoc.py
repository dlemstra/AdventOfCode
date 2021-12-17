import sys
from types import resolve_bases

def checkVelocity(velocityX, velocityY, minX, maxX, minY, maxY):
    bestY = -sys.maxsize

    x = 0
    y = 0
    for _ in range(0, 500):
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

    return -sys.maxsize

def trickShot(input):
    info = input[0].split(",")
    (minX, maxX) = map(int, info[0].split('=')[1].split('..'))
    (maxY, minY) = map(int, info[1].split('=')[1].split('..'))

    part1 = -sys.maxsize
    for y in range(-200, 200):
        for x in range(-200, 200):
            result = checkVelocity(x, y, minX, maxX, minY, maxY)
            part1 = max(part1, result)
    print('done', part1)

    return (part1, None)
