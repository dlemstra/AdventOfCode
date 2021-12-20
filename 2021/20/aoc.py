def getNumber(pixels, x, y, border):
    value = 0
    for y1 in range(y - 1, y + 2):
        for x1 in range(x - 1, x + 2):
            value <<= 1
            key = f"{x1}x{y1}"
            if key in pixels:
                if pixels[key] == '#':
                    value |= 1
            elif border == '#':
                value |= 1

    return value

def extentImage(image, algorithm, count):
    pixels = {}

    minX = 0
    maxX = len(image[0])
    minY = 0
    maxY = len(image)
    for y in range(minY, maxY):
        for x in range(minX, maxX):
            pixels[f"{x}x{y}"] = image[y][x]

    border='.'
    for i in range(count):
        newPixels = {}
        minX -= 1
        maxX += 1
        minY -= 1
        maxY += 1
        for y in range(minY, maxY):
            for x in range(minX, maxX):
                number = getNumber(pixels, x, y, border)
                value = algorithm[number]
                if value != 0:
                    newPixels[f"{x}x{y}"] = value
        pixels = newPixels

        if i % 2 == 0:
            border=algorithm[0]
        else:
            border=algorithm[0x1ff]

    count = 0
    for y in range(minY, maxY):
        for x in range(minX, maxX):
            if pixels[f"{x}x{y}"] == '#': count += 1

    return count

def trenchMap(input):
    algorithm = input[0]

    image = []
    for j in range(2, len(input)):
        image.append(input[j])

    part1 = extentImage(image, algorithm, 2)
    part2 = extentImage(image, algorithm, 50)

    return (part1, part2)
