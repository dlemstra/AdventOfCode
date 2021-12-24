class State:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y and self.z == other.z

    def __hash__(self):
        return hash((self.x, self.y, self.z))

    def __str__(self):
        return f"{self.x},{self.y},{self.z}"

def getValue(registers, key):
    if key in registers:
        return registers[key]
    return int(key)

def executeInstructions(instructions, registers, input):
    for line in instructions:
        match line[0]:
            case 'i':
                registers[line[4]] = input.pop(0)
            case 'a':
                registers[line[4]] += getValue(registers, line[6:])
            case 'm':
                match line[1]:
                    case 'u':
                        registers[line[4]] *= getValue(registers, line[6:])
                    case 'o':
                        value = getValue(registers, line[6:])
                        if value == 0:
                            return None
                        registers[line[4]] %= value
            case 'd':
                value = getValue(registers, line[6:])
                if value == 0:
                    return None
                registers[line[4]] = int(registers[line[4]] / value)
            case 'e':
                value1 = registers[line[4]]
                value2 = getValue(registers, line[6:])
                registers[line[4]] = 1 if value1 == value2 else 0

    return registers

def parseInput(input):
    block = [input[0]]
    for line in input[1:]:
        if line[0:3] == "inp":
            yield block
            block = []
        block.append(line)

    yield block

def createRegister(state):
    register = {}
    register['x'] = state.x
    register['y'] = state.y
    register['z'] = state.z

    return register

def arithmeticLogicUnit(input):
    blocks = list(parseInput(input))

    states = {}
    states[State(0,0,0)] = 0

    for i in range(0, 14):
        newStates = {}
        for state in states:
            previous = states[state]
            for w in range(1, 10):
                register = createRegister(state)
                output = executeInstructions(blocks[i], register, [w])
                newState = State(output['x'], output['y'], output['z'])
                if newState.z < 1000000:
                    value = previous * 10 + w
                    if newState not in newStates:
                        newStates[newState] = value
                    else:
                        newStates[newState] = max(value, newStates[newState])

        states = newStates

    part1 = 0
    for state in states:
        if state.z == 0:
            part1 = max(states[state], part1)

    return (part1, None)
