import sys

class Room:
    def __init__(self, index, amphipod1, amphipod2):
        self.index = index
        self.content = [amphipod1, amphipod2]

    def __str__(self):
        return str(self.content)

    def clone(self):
        return Room(self.index, self.content[0], self.content[1])

    def empty(self):
        return self.content[0] == '.' and self.content[1] == '.'

    def done(self):
        return self.isWantedValue(self.content[1]) and self.isWantedValue(self.content[0])

    def takeTopItem(self):
        if self.done() or self.empty():
            return None

        value = self.content[0]
        if value != '.':
            self.content[0] = '.'
            return value

        value = self.content[1]
        if self.isWantedValue(value):
            return None

        if value != '.':
            self.content[1] = '.'
            return value

        return None

    def putValueInRoom(self, value):
        if not self.isWantedValue(value):
            return False

        if self.content[1] == '.':
            self.content[1] = value
            return True

        if self.content[0] == '.':
            self.content[0] = value
            return True

        return False

    def isWantedValue(self, value):
        match self.index:
            case 0: return value == 'A'
            case 1: return value == 'B'
            case 2: return value == 'C'
            case 3: return value == 'D'
        return True

class Maze:
    def __init__(self):
        self.rooms = list(range(4))
        self.hallway = ['.'] * 7
        self.totalEnergy = 0

    def checkSum(self):
        return ''.join(map(str, self.rooms)) + ''.join(self.hallway)

    def clone(self):
        clone = Maze()
        for i in range(0, len(self.rooms)):
            clone.rooms[i] = self.rooms[i].clone()
        clone.hallway = self.hallway.copy()
        clone.totalEnergy = self.totalEnergy

        return clone

    def done(self):
        for i in range(0, len(self.rooms)):
            if not self.rooms[i].done():
                return False

        return True

    def possibleMoves(self):
        for room in self.rooms:
            if not room.empty():
                for hallwayIndex in self.possibleHallways(room.index):
                    clone = self.clone()
                    clonedRoom = clone.rooms[room.index]
                    value = clonedRoom.takeTopItem()
                    if value is not None:
                        clone.hallway[hallwayIndex] = value
                        energy = self.itemEnergy(value)
                        clone.totalEnergy += energy * self.stepCount(room.index, hallwayIndex)
                        if clonedRoom.empty():
                            clone.totalEnergy += energy

                        yield clone

            for hallwayIndex in self.possibleAmphipods(room.index):
                clone = self.clone()
                clonedRoom = clone.rooms[room.index]
                value = clone.hallway[hallwayIndex]
                if clonedRoom.putValueInRoom(value):
                    clone.hallway[hallwayIndex] = '.'
                    energy = self.itemEnergy(value)
                    clone.totalEnergy += energy * self.stepCount(room.index, hallwayIndex)
                    if not clonedRoom.done():
                        clone.totalEnergy += energy

                    yield clone

    def possibleHallways(self, roomIndex):
        result = []
        for range in self.possibleRanges(roomIndex):
            for index in range:
                if self.hallway[index] != '.':
                    break
                result.append(index)

        return list(set(result))

    def possibleAmphipods(self, roomIndex):
        result = []
        for range in self.possibleRanges(roomIndex):
            for index in range:
                if self.hallway[index] != '.':
                    result.append(index)
                    break

        return list(set(result))

    def possibleRanges(self, roomIndex):
        match roomIndex:
            case 0: return [[1, 0], [2, 3, 4, 5, 6]]
            case 1: return [[2, 1, 0], [3, 4, 5, 6]]
            case 2: return [[3, 2, 1, 0], [4, 5, 6]]
            case 3: return [[4, 3, 2, 1, 0], [5, 6]]

    def itemEnergy(self, value):
        match value:
            case 'A': return 1
            case 'B': return 10
            case 'C': return 100
            case 'D': return 1000

        print(value)
        raise

    def stepCount(self, roomIndex, hallwayIndex):
        match roomIndex:
            case 0: return [3,2,2,4,6,8,9][hallwayIndex]
            case 1: return [5,4,2,2,4,6,7][hallwayIndex]
            case 2: return [7,6,4,2,2,4,5][hallwayIndex]
            case 3: return [9,8,6,4,2,2,3][hallwayIndex]

        print(roomIndex)
        raise

def readMaze(input):
    maze = Maze()
    maze.rooms[0] = Room(0, input[2][3], input[3][3])
    maze.rooms[1] = Room(1, input[2][5], input[3][5])
    maze.rooms[2] = Room(2, input[2][7], input[3][7])
    maze.rooms[3] = Room(3, input[2][9], input[3][9])
    return maze

def amphipod(input):
    part1 = sys.maxsize

    maze = readMaze(input)

    energyTotals = {}
    stack = [maze]
    while len(stack) != 0:
        maze = stack.pop(0)
        if maze.done():
            part1 = min(part1, maze.totalEnergy)
            continue

        checksum = maze.checkSum()
        if checksum in energyTotals and maze.totalEnergy > energyTotals[checksum]:
            continue

        for move in maze.possibleMoves():
            checksum = move.checkSum()
            if checksum in energyTotals and move.totalEnergy >= energyTotals[checksum]:
                continue

            energyTotals[checksum] = move.totalEnergy

            stack.append(move)

    return (part1, None)
