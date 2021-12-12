class State:
    def __init__(self, key, visitedSmallTwice = False, visited = []):
        self.key = key
        self.visited = visited.copy()
        if not visitedSmallTwice and key.islower() and key in self.visited:
            self.visitedSmallTwice = True
        else:
            self.visitedSmallTwice = visitedSmallTwice
        self.visited.append(key)

    def __str__(self):
        return ','.join(self.visited)

    def clone(self, newKey):
        return State(newKey, self.visitedSmallTwice, self.visited)

    def possibleExitsPart1(self, maze):
        for exit in maze[self.key]:
            if exit == 'start': continue
            if exit.islower() and exit in self.visited: continue
            yield exit

    def possibleExitsPart2(self, maze):
        for exit in maze[self.key]:
            if exit == 'start': continue
            if exit.islower() and exit in self.visited and self.visitedSmallTwice:
                continue
            yield exit

def readMaze(input):
    maze = {}
    for line in input:
        (a, b) = line.split('-')
        if a not in maze:
            maze[a] = []
        if b not in maze:
            maze[b] = []
        maze[a].append(b)
        maze[b].append(a)

    return maze

def passagePathing(input):
    maze = readMaze(input)

    part1 = 0

    stack = []
    stack.append(State('start'))

    while len(stack) > 0:
        state = stack.pop()
        for exit in state.possibleExitsPart1(maze):
            if exit == 'end':
                part1 += 1
            else:
                stack.append(state.clone(exit))

    part2 = 0

    stack = []
    stack.append(State('start'))

    while len(stack) > 0:
        state = stack.pop()
        for exit in state.possibleExitsPart2(maze):
            if exit == 'end':
                part2 += 1
            else:
                stack.append(state.clone(exit))

    return (part1, part2)
