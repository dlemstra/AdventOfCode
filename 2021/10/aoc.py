def score(stack):
    score = 0
    while len(stack) > 0:
        c = stack.pop()
        score *= 5
        match c:
            case '(':
                score += 1
            case '[':
                score += 2
            case '{':
                score += 3
            case '<':
                score += 4
    return score

def syntaxScoring(input):
    part1 = 0

    incomplete = []

    for line in input:
        stack = []
        invalid = None
        for c in line:
            if c in ['(', '[', '{', '<']:
                stack.append(c)
            else:
                match c:
                    case ')':
                        if stack.pop() != '(':
                            invalid = c
                            break
                    case ']':
                        if stack.pop() != '[':
                            invalid = c
                            break
                    case '}':
                        if stack.pop() != '{':
                            invalid = c
                            break
                    case '>':
                        if stack.pop() != '<':
                            invalid = c
                            break
        match invalid:
            case ')':
                part1 += 3
            case ']':
                part1 += 57
            case '}':
                part1 += 1197
            case '>':
                part1 += 25137
            case None:
                incomplete.append(stack)

    numbers = sorted(map(score, incomplete))
    part2 = numbers[int(len(numbers)/2)]

    return (part1, part2)
