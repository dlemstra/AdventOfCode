def syntaxScoring(input):
    part1 = 0

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

    return (part1, None)
