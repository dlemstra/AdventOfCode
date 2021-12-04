def playBingo(numbers, boards):
    while len(numbers) > 0:
        number = numbers.pop()

        for board in boards:
            for values in board:
                if number in values:
                    values.remove(number)
                    if len(values) == 0:
                        return (board, number)

def findWorst(numbers, boards):
    while len(boards) != 1:
        (best_board, last_number) = playBingo(numbers, boards)
        boards.remove(best_board)
        numbers.append(last_number)

    return playBingo(numbers, boards)

def score(board, last_number):
    remaining = []
    for values in board:
        for value in values:
            if value not in remaining and value != last_number: remaining.append(value)

    return last_number * sum(remaining)

def createBoards(input):
    boards = []

    for i in range(1, len(input), 6):
        rows = []

        for line in input[i+1:i+6]:
            row = list(map(int, ' '.join(line.split()).split(' ')))
            rows.append(row)

        board = []
        for j in range(0, len(rows[0])):
            column = []
            for row in rows:
                column.append(row[j])
            board.append(column)

        board.extend(rows)
        boards.append(board)

    return boards

def giantSquid(input):
    numbers = list(map(int, input[0].split(',')))
    numbers.reverse()

    boards = createBoards(input)

    (best_board, last_number) = playBingo(numbers.copy(), boards)
    part1 = score(best_board, last_number)

    boards = createBoards(input)

    (worst_board, last_number) = findWorst(numbers, boards)
    part2 = score(worst_board, last_number)

    return (part1, part2)
