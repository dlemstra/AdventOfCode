class State:
    def __init__(self, key, visited = []):
        self.key = key
        self.visited = visited
        self.visited.append(key)

    def clone(self, newKey):
        return State(newKey, self.visited.copy())

    def possibleExits(self, maze):
        for exit in maze[self.key]:
            if exit == 'start': continue
            if exit.islower() and exit in self.visited: continue
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
        for exit in state.possibleExits(maze):
            if exit == 'end':
                part1 += 1
            else:
                stack.append(state.clone(exit))

    return (part1, None)
