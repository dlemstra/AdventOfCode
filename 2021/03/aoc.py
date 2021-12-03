def createNumbers(input, bits):
    numbers = []
    for line in input:
        mask = 1 << bits
        value = 0
        for bit in line:
            if bit == '1':
                value |= mask
            mask = mask >> 1
        numbers.append(value)

    return numbers

def findMatches(numbers, bits, bit):
    matches = []
    no_matches = []
    for number in numbers:
        if number & bit:
            matches.append(number)
        else:
            no_matches.append(number)
    return(matches, no_matches)

def mostCommon(numbers, bits, bit):
    (matches, no_matches) = findMatches(numbers, bits, bit)
    return matches if len(matches) >= len(no_matches) else no_matches

def leastCommon(numbers, bits, bit):
    (matches, no_matches) = findMatches(numbers, bits, bit)
    return matches if len(matches) < len(no_matches) else no_matches

def binaryDiagnostic(input):
    mask = 1
    least = 0
    most = 0
    for i in range(len(input[0])-1, -1, -1):
        count_0 = 0
        count_1 = 0

        for line in input:
            if line[i] == '0':
                count_0 += 1
            else:
                count_1 += 1

        if count_0 > count_1:
            least |= mask
        else:
            most |= mask
        mask = mask << 1

    part1 = least * most

    bits = len(input[0]) - 1
    numbers = createNumbers(input, bits)

    most = numbers
    mask = 1 << bits
    while len(most) != 1:
        most = mostCommon(most, bits, mask)
        mask = mask >> 1

    least = numbers
    mask = 1 << bits
    while len(least) != 1:
        least = leastCommon(least, bits, mask)
        mask = mask >> 1

    part2 = least[0] * most[0]

    return (part1, part2)
