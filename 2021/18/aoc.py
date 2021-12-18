from itertools import combinations

def createList(line):
    data = ''
    stack = []
    for c in line:
        match c:
            case '[':
                stack.append([])
            case ']':
                if data != '':
                    stack[-1].append(int(data))
                    data = ''
                if len(stack) > 1:
                    last = stack.pop()
                    stack[-1].append(last)
            case ',':
                if data != '':
                    stack[-1].append(int(data))
                    data = ''
            case _:
                data += c
    return stack.pop()

def addLeft(data, index, value):
    if value == 0 or index < 0:
        return False

    i = index
    while i >= 0:
        if isinstance(data[i], list):
            if addLeft(data[i], len(data[i]) - 1, value):
                return True
        else:
            data[i] += value
            return True
        i -= 1

    return False

def addRight(data, index, value):
    if value == 0 or index == len(data):
        return False

    for i in range (index, len(data)):
        if isinstance(data[i], list):
            if addRight(data[i], 0, value):
                return True
        else:
            data[i] += value
            return True

    return False

def explode(data, depth = 0):
    if not isinstance(data, list):
        return None

    if depth == 3:
        for i in range(0, len(data)):
            item = data[i]
            if isinstance(item, list):
                left = item[0]
                right = item[1]
                if addLeft(data, i - 1, left):
                    left = 0
                if addRight(data, i + 1, right):
                    right = 0

                data[i] = 0

                return (left, right)

        return None

    for i in range(0, len(data)):
        result = explode(data[i], depth + 1)
        if result is not None:
            left = result[0]
            right = result[1]
            if addLeft(data, i - 1, left):
                left = 0
            if addRight(data, i + 1, right):
                right = 0

            return (left, right)

    return None

def split(data):
    for i in range(0, len(data)):
        if isinstance(data[i], list):
            if split(data[i]):
                return True
        elif data[i] >= 10:
            left = 5
            right = 5
            while left + right != data[i]:
                right += 1
                if left + right == data[i]:
                    break
                left += 1

            data[i] = [left, right]

            return True

    return False

def addition(left, right):
    data = [left, right]
    while explode(data) or split(data):
        explode(data)

    return data

def magnitude(data):
    for i in range(0, len(data)):
        if isinstance(data[i], list):
            data[i] = magnitude(data[i])

    return (data[0] * 3) + (data[1] * 2)

def snailfish(input):
    left = createList(input[0])
    for i in range(1, len(input)):
        right = createList(input[i])
        left = addition(left, right)
    part1 = magnitude(left)

    part2 = 0
    for (a, b) in combinations(input, 2):
        left = createList(a)
        right = createList(b)
        part2 = max(part2, magnitude(addition(left, right)))
        left = createList(b)
        right = createList(a)
        part2 = max(part2, magnitude(addition(left, right)))

    return (part1, part2)
