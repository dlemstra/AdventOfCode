def dive(input):
    part1_horizontal = 0
    part1_depth = 0
    aim = 0
    part2_horizontal = 0
    part2_depth = 0
    for line in input:
        info = line.split(' ')
        value = int(info[1])
        match info[0][0]:
            case 'f':
                part1_horizontal += value
                part2_horizontal += value
                part2_depth += aim * value
            case 'u':
                part1_depth -= value
                aim -= value
            case 'd':
                part1_depth += value
                aim += value
    return (part1_horizontal * part1_depth, part2_horizontal * part2_depth)
