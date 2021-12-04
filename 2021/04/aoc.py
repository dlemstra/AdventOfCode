def playBingo(numbers, boards):
    while len(numbers) > 0:
        number = numbers.pop()

        for board in boards:
            for values in board:
                if number in values:
                    values.remove(number)
                    if len(values) == 0:
                        return (board, number)

def giantSquid(input):
    numbers = list(map(int, input[0].split(',')))
    numbers.reverse()

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

    remaining = []
    (best_board, last_number) = playBingo(numbers, boards)
    for values in best_board:
        for value in values:
            if value not in remaining and value != last_number: remaining.append(value)

    part1 = last_number * sum(remaining)

    return (part1, None)
