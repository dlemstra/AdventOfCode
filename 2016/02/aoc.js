module.exports = {
    bathroomSecurity: function(input) {
        const keypad = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
        ]

        let code = ''
        let x = 1
        let y = 1
        const lines = input.split('\n')
        lines.forEach(line => {
            const steps = line.split('')
            steps.forEach(step => {
                switch(step) {
                    case 'U':
                        if (y > 0) { y -= 1 }
                        break;
                    case 'D':
                        if (y < 2) { y += 1 }
                        break;
                    case 'L':
                        if (x > 0) { x -= 1 }
                        break;
                    case 'R':
                        if (x < 2) { x += 1 }
                        break;
                }
            })

            code += keypad[y][x]
        })

        return code;
    }
}
