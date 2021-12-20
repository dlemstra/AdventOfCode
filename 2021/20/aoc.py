def getNumber(pixels, x, y):
    value = 0
    for y1 in range(y - 1, y + 2):
        for x1 in range(x - 1, x + 2):
            value <<= 1
            key = f"{x1}x{y1}"
            if key in pixels and pixels[key] == '#':
                value |= 1

    return value

def extentImage(image, algorithm):
    pixels = {}

    minX = 0
    maxX = len(image[0])
    minY = 0
    maxY = len(image)
    for y in range(minY, maxY):
        for x in range(minX, maxX):
            pixels[f"{x}x{y}"] = image[y][x]

    area = 3
    for _ in range(2):
        newPixels = {}
        minX -= area
        maxX += area
        minY -= area
        maxY += area
        for y in range(minY, maxY):
            for x in range(minX, maxX):
                number = getNumber(pixels, x, y)
                value = algorithm[number]
                if value != 0:
                    newPixels[f"{x}x{y}"] = value
        pixels = newPixels

    area += 1
    count = 0
    for y in range(minY + area, maxY - area):
        for x in range(minX + area, maxX - area):
            if pixels[f"{x}x{y}"] == '#': count += 1

    return count

def trenchMap(input):
    algorithm = input[0]

    image = []
    for j in range(2, len(input)):
        image.append(input[j])

    part1 = extentImage(image, algorithm)

    return (part1, None)
