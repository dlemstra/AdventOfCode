from itertools import *

class Position:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

class Scanner:
    def __init__(self, index):
        self.index = index
        self.beacons = []
        self.rotations = []
        self.position = None

    def addBeacon(self, beacon):
        self.beacons.append(beacon)

    def createRotations(self):
        for beacon in self.beacons:
            values = [beacon.x, beacon.y, beacon.z]
            for p in permutations(range(0, 3)):
                for m in product([-1, 1], [-1, 1], [-1, 1]):
                    x = values[p[0]] * m[0]
                    y = values[p[1]] * m[1]
                    z = values[p[2]] * m[2]
                    self.rotations.append((Position(x, y, z), p, m))

def readScanners(input):
    scanners = []
    scanner = None
    index = 0
    for line in input:
        if scanner is None:
            scanner = Scanner(index)
            scanners.append(scanner)
            index += 1
        elif line == '':
            scanner = None
        else:
            info = list(map(int,line.split(',')))
            scanner.addBeacon(Position(info[0], info[1], info[2]))

    for scanner in scanners:
        scanner.createRotations()

    return scanners

def incrementKey(dictionary, key):
    if key not in dictionary:
        dictionary[key] = 0
    dictionary[key] += 1

    return dictionary[key]

def findPosition(scanner1, scanner2):
    deltas = {}
    for beacon1 in scanner1.beacons:
        for (position, p, m) in scanner2.rotations:
            x = beacon1.x - position.x
            y = beacon1.y - position.y
            z = beacon1.z - position.z
            if incrementKey(deltas, f"{x},{y},{z}") == 12:
                return (Position(x, y, z), p, m)

    return None

def beaconScanner(input):
    scanners = readScanners(input)

    scanners[0].position = Position(0, 0, 0)
    foundScanners = [scanners.pop(0)]

    checked = []
    while len(scanners) > 0:
        for i in range(0, len(foundScanners)):
            for j in range(0, len(scanners)):
                scanner1 = foundScanners[i]
                scanner2 = scanners[j]
                combo = f"{scanner1.index}-{scanner2.index}"
                if combo in checked:
                    continue

                checked.append(combo)

                position = findPosition(scanner1, scanner2)

                if position != None:
                    (_, p, m) = position
                    for beacon in scanner2.beacons:
                        values = [beacon.x, beacon.y, beacon.z]
                        beacon.x = values[p[0]] * m[0]
                        beacon.y = values[p[1]] * m[1]
                        beacon.z = values[p[2]] * m[2]

                    (position, _, _) = findPosition(scanner1, scanner2)

                    x = scanner1.position.x + position.x
                    y = scanner1.position.y + position.y
                    z = scanner1.position.z + position.z
                    scanner2.position = Position(x, y, z)
                    foundScanners.append(scanners.pop(j))
                    break

        print(f"Found {len(foundScanners)}, remaining {len(scanners)}.")

    beacons = []

    for scanner in foundScanners:
        for beacon in scanner.beacons:
            x = beacon.x + scanner.position.x
            y = beacon.y + scanner.position.y
            z = beacon.z + scanner.position.z
            position = f"{x},{y},{z}"
            if position not in beacons:
                beacons.append(position)

    part1 = len(beacons)

    part2 = 0
    for i in range(0, len(foundScanners)):
        for j in range(0, len(foundScanners)):
            if i == j: continue
            pos1 = foundScanners[i].position
            pos2 = foundScanners[j].position

            distance = abs(pos1.x - pos2.x) + abs(pos1.y - pos2.y) + abs(pos1.z - pos2.z)
            part2 = max(part2, distance)

    print('')
    return (part1, part2)
