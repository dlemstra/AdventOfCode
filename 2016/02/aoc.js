function isValidStep(x, y, part) {
    if (part == 1) {
        return x >= 0 && x <= 2 && y >= 0 && y <= 2
    }

    if (y == 0 || y == 4) { return x == 2 }
    if (y == 1 || y == 3) { return x > 0 && x < 4 }
    if (y == 2) { return x >= 0 && x <= 4 }

    return false
}

function takeStep(x, y, step, part) {
    switch(step) {
        case 'U':
            if (isValidStep(x, y - 1, part)) { y -= 1 }
            break;
        case 'D':
            if (isValidStep(x, y + 1, part)) { y += 1 }
            break;
        case 'L':
            if (isValidStep(x - 1, y, part)) { x -= 1 }
            break;
        case 'R':
            if (isValidStep(x + 1, y, part)) { x += 1 }
            break;
    }

    return [x, y]
}

module.exports = {
    bathroomSecurity: function(input) {
        const keypad1 = [
            ['1', '2', '3'],
            ['4', '5', '6'],
            ['7', '8', '9']
        ]

        const keypad2 = [
            [' ', ' ', '1', ' ', ' '],
            [' ', '2', '3', '4', ' '],
            ['5', '6', '7', '8', '9'],
            [' ', 'A', 'B', 'C', ' '],
            [' ', ' ', 'D', ' ', ' '],
        ]

        let code1 = ''
        let code2 = ''
        let x1 = 1
        let y1 = 1
        let x2 = 0
        let y2 = 2
        const lines = input.split('\n')
        lines.forEach(line => {
            const steps = line.split('')
            steps.forEach(step => {
                [x1, y1] = takeStep(x1, y1, step, 1);
                [x2, y2] = takeStep(x2, y2, step, 2)
            })

            code1 += keypad1[y1][x1]
            code2 += keypad2[y2][x2]
        })

        return [code1, code2]
    }
}
