import sys

def matches1478(value):
    count = 0
    for v in value.split(' '):
        length = len(v)
        if (length == 2 or length == 3 or length == 4 or length == 7):
            count += 1
    return count

def sevenSegmentSearch(input):
    part1 = 0

    for line in input:
        (start, end) = line.split(' | ')
        part1 += matches1478(end)

    return (part1, None)
