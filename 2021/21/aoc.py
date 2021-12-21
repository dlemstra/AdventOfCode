def dicePart1(player1_pos, player2_pos):
    player1_score = 0
    player2_score = 0

    dice = 1
    while player1_score < 1000 and player2_score < 1000:
        total = dice + dice + 1 + dice + 2
        player1_pos = (player1_pos + total) % 10
        if player1_pos == 0:
            player1_pos = 10
        player1_score += player1_pos
        dice += 3
        if player1_score >= 1000:
            break

        total = dice + dice + 1 + dice + 2
        player2_pos = (player2_pos + total) % 10
        if player2_pos == 0:
            player2_pos = 10
        player2_score += player2_pos
        dice += 3

    dice -= 1
    if player1_score > player2_score:
        return player2_score * dice
    else:
        return player1_score * dice

def dicePart2(player1_pos, player1_score, player2_pos, player2_score, player, dice, totals, total):
    if dice > 0:
        if player == 1:
            player1_pos = (player1_pos + dice) % 10
            if player1_pos == 0:
                player1_pos = 10
            player1_score += player1_pos
            if player1_score >= total:
                return (1, 0)
        else:
            player2_pos = (player2_pos + dice) % 10
            if player2_pos == 0:
                player2_pos = 10
            player2_score += player2_pos
            if player2_score >= total:
                return (0, 1)

    one_wins = 0
    two_wins = 0

    next_player = 2 if player == 1 else 1
    for dice in totals:
        (one, two) = dicePart2(player1_pos, player1_score, player2_pos, player2_score, next_player, dice, totals, total)
        if one > 0:
            one_wins += one * totals[dice]
        if two > 0:
            two_wins += two * totals[dice]

    return (one_wins, two_wins)

def diracDice(input):
    player1_pos = int(input[0].split(': ')[1])
    player2_pos = int(input[1].split(': ')[1])
    part1 = dicePart1(player1_pos, player2_pos)

    totals = {}
    for one in range(1, 4):
        for two in range(1, 4):
            for three in range(1, 4):
                total = one + two + three
                if total not in totals:
                    totals[total] = 0
                totals[total] += 1

    (one, two) = dicePart2(player1_pos, 0, player2_pos, 0, 2, 0, totals, 21)
    part2 = max(one, two)

    return (part1, part2)
