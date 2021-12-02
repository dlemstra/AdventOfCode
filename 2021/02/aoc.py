def dive(input):
    horizontal = 0
    depth = 0
    for line in input:
        info = line.split(' ')
        value = int(info[1])
        match info[0][0]:
            case 'f':
                horizontal += value
            case 'u':
                depth -= value
            case 'd':
                depth += value
    return horizontal * depth
