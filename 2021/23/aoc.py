import sys

class Room:
    def __init__(self, index):
        self.index = index
        self.content = []
        self.size = 0

    def __str__(self):
        return str(self.content)

    def clone(self):
        clone = Room(self.index)
        clone.content = self.content.copy()
        clone.size = self.size
        return clone

    def setContent(self, content):
        self.content = content.copy()
        self.size = len(self.content)

    def empty(self):
        return len(self.content) == 0

    def done(self):
        return len(self.content) == self.size and all(self.isWantedValue(c) for c in self.content)

    def takeTopItem(self):
        if self.empty() or self.done():
            return None

        if all(self.isWantedValue(c) for c in self.content):
            return None

        return self.content.pop()

    def putValueInRoom(self, value):
        if not self.isWantedValue(value):
            return False

        if self.done():
            return False

        if not all(self.isWantedValue(c) for c in self.content):
            return False

        self.content.append(value)
        return True

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

    def clone(self):
        clone = Maze()
        for i in range(0, len(self.rooms)):
            clone.rooms[i] = self.rooms[i].clone()
        clone.hallway = self.hallway.copy()
        clone.totalEnergy = self.totalEnergy
        return clone

    def checkSum(self):
        return ''.join(map(str, self.rooms)) + ''.join(self.hallway)

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
                        clone.totalEnergy += energy * clone.stepCount(room.index, hallwayIndex)
                        clone.totalEnergy += energy * (clone.rooms[room.index].size - 1 - len(clone.rooms[room.index].content))

                        yield clone

            for hallwayIndex in self.possibleAmphipods(room.index):
                clone = self.clone()
                clonedRoom = clone.rooms[room.index]
                value = clone.hallway[hallwayIndex]
                if clonedRoom.putValueInRoom(value):
                    clone.hallway[hallwayIndex] = '.'
                    energy = self.itemEnergy(value)
                    clone.totalEnergy += energy * clone.stepCount(room.index, hallwayIndex)
                    clone.totalEnergy += energy * (clone.rooms[room.index].size - len(clone.rooms[room.index].content))

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

    def stepCount(self, roomIndex, hallwayIndex):
        match roomIndex:
            case 0: return [3,2,2,4,6,8,9][hallwayIndex]
            case 1: return [5,4,2,2,4,6,7][hallwayIndex]
            case 2: return [7,6,4,2,2,4,5][hallwayIndex]
            case 3: return [9,8,6,4,2,2,3][hallwayIndex]

    def roomValue(self, room, index):
        if index < len(self.rooms[room].content):
            return self.rooms[room].content[index]
        else:
            return '.'

def readMaze(input):
    maze = Maze()
    maze.rooms[0] = Room(0)
    maze.rooms[0].setContent([input[3][3], input[2][3]])
    maze.rooms[1] = Room(1)
    maze.rooms[1].setContent([input[3][5], input[2][5]])
    maze.rooms[2] = Room(2)
    maze.rooms[2].setContent([input[3][7], input[2][7]])
    maze.rooms[3] = Room(3)
    maze.rooms[3].setContent([input[3][9], input[2][9]])
    return maze

def solveMaze(maze):
    result = sys.maxsize
    energyTotals = {}
    stack = [maze]
    while len(stack) != 0:
        maze = stack.pop(0)
        if maze.done():
            result = min(result, maze.totalEnergy)
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

    return result

def amphipod(input):
    maze = readMaze(input)
    part1 = solveMaze(maze.clone())

    maze.rooms[0].setContent([maze.rooms[0].content[0], 'D', 'D', maze.rooms[0].content[1]])
    maze.rooms[1].setContent([maze.rooms[1].content[0], 'B', 'C', maze.rooms[1].content[1]])
    maze.rooms[2].setContent([maze.rooms[2].content[0], 'A', 'B', maze.rooms[2].content[1]])
    maze.rooms[3].setContent([maze.rooms[3].content[0], 'C', 'A', maze.rooms[3].content[1]])

    part2 = solveMaze(maze)

    return (part1, part2)
