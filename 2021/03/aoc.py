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
    return (part1, None)
