def matches1478(value):
    count = 0
    for v in value.split(' '):
        length = len(v)
        if (length == 2 or length == 3 or length == 4 or length == 7):
            count += 1
    return count

def findByLength(numbers, length):
    return (number for number in numbers if len(number) == length)

def getNumberMapping(value):
    info = value.split(' ')
    one = list(next(findByLength(info, 2)))
    four = list(next(findByLength(info, 4)))
    seven = list(next(findByLength(info, 3)))
    eight = list(next(findByLength(info, 7)))

    sixCount = list(findByLength(info, 6))
    for value in sixCount:
        remaining = [x for x in value if x not in four]
        remaining = [x for x in remaining if x not in seven]
        if len(remaining) == 1:
            nine = list(value)

    for value in [x for x in sixCount if x != ''.join(nine)]:
        remaining = [x for x in value if x not in seven]
        if len(remaining) == 3:
            zero = list(value)
        else:
            six = list(value)

    fiveCount = list(findByLength(info, 5))
    for value in fiveCount:
        remaining = [x for x in value if x not in seven]
        if len(remaining) == 2:
            three = list(value)

    for value in [x for x in fiveCount if x != ''.join(three)]:
        remaining = [x for x in value if x not in six]
        if len(remaining) == 0:
            five = list(value)
        else:
            two = list(value)

    mapping = {}
    mapping[''.join(sorted(zero))] = '0'
    mapping[''.join(sorted(one))] = '1'
    mapping[''.join(sorted(two))] = '2'
    mapping[''.join(sorted(three))] = '3'
    mapping[''.join(sorted(four))] = '4'
    mapping[''.join(sorted(five))] = '5'
    mapping[''.join(sorted(six))] = '6'
    mapping[''.join(sorted(seven))] = '7'
    mapping[''.join(sorted(eight))] = '8'
    mapping[''.join(sorted(nine))] = '9'
    return mapping

def getOutput(line):
    (start, end) = line.split(' | ')

    mapping = getNumberMapping(start)

    code = ''
    for value in end.split(' '):
        value = ''.join(sorted(list(value)))
        code += mapping[value]

    return int(code)

def sevenSegmentSearch(input):
    part1 = 0
    for line in input:
        (_, end) = line.split(' | ')
        part1 += matches1478(end)

    part2 = 0
    for line in input:
        part2 += getOutput(line)

    return (part1, part2)
