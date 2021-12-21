def roll(dice):
    total = dice
    dice += 1
    total += dice
    dice += 1
    total += dice
    dice += 1
    return (dice, total)

def diracDice(input):
    part1 = 0

    player1_pos = int(input[0].split(': ')[1])
    player1_score = 0
    player2_pos = int(input[1].split(': ')[1])
    player2_score = 0

    dice = 1
    while player1_score < 1000 and player2_score < 1000:
        (dice, total) = roll(dice)
        player1_pos = (player1_pos + total) % 10
        if player1_pos == 0:
            player1_pos = 10
        player1_score += player1_pos
        if player1_score >= 1000:
            break

        (dice, total) = roll(dice)
        player2_pos = (player2_pos + total) % 10
        if player2_pos == 0:
            player2_pos = 10
        player2_score += player2_pos

    dice -= 1
    if player1_score > player2_score:
        part1 = player2_score * dice
    else:
        part1 = player1_score * dice

    return (part1, None)
