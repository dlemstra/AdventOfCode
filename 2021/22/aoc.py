class Cube:
    def __init__(self, minX, maxX, minY, maxY, minZ, maxZ, on):
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
        self.maxY = maxY
        self.minZ = minZ
        self.maxZ = maxZ
        self.on = on

    def inPart1(self):
        return False if self.minX < -50 or self.maxX > 50 or \
                        self.minY < -50 or self.maxY > 50 or \
                        self.minZ < -50 or self.maxZ > 50 else True

    def size(self):
        return (self.maxX - self.minX + 1) * (self.maxY - self.minY + 1) * (self.maxZ - self.minZ + 1)

    def overlappingCube(self, other):
        maxX = min(other.maxX,self.maxX)
        minX = max(other.minX,self.minX)
        if maxX - minX < 0:
            return None
        maxY = min(other.maxY,self.maxY)
        minY = max(other.minY,self.minY)
        if maxY - minY < 0:
            return None
        maxZ = min(other.maxZ,self.maxZ)
        minZ = max(other.minZ,self.minZ)
        if maxZ - minZ < 0:
            return None

        return Cube(minX, maxX, minY, maxY, minZ, maxZ, not self.on)

def getTotalOn(cubes):
    newCubes = [cubes[0]]
    for cube in cubes[1:]:
        for other in newCubes.copy():
            overlappingCube = other.overlappingCube(cube)
            if overlappingCube is not None:
                newCubes.append(overlappingCube)
        if cube.on:
            newCubes.append(cube)

    totalOn = 0
    for cube in newCubes:
        if cube.on:
            totalOn += cube.size()
        else:
            totalOn -= cube.size()

    return totalOn

def reactorReboot(input):
    part1 = 0

    cubes = []
    for line in input:
        info = line.split(' ')
        state = info[0]
        info = info[1].split(',')
        (minX, maxX) = map(int,info[0].split('=')[1].split('..'))
        (minY, maxY) = map(int,info[1].split('=')[1].split('..'))
        (minZ, maxZ) = map(int,info[2].split('=')[1].split('..'))
        cubes.append(Cube(minX, maxX, minY, maxY, minZ, maxZ, True if state =='on' else False))

    part1 = getTotalOn(list(filter(lambda cube: cube.inPart1(), cubes)))
    part2 = getTotalOn(cubes)

    return (part1, part2)
