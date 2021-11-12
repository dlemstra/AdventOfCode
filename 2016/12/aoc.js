function valueOfRegisterA(lines, registers) {
    let index = 0
    while (index >= 0 && index < lines.length) {
        const line = lines[index]
        let steps = 1
        switch(line[0][0]) {
            case 'c':
            {
                let value = parseInt(line[1])
                if (isNaN(value)) {
                    value = registers[line[1]] || 0
                }
                registers[line[2]] = value
                break;
            }
            case 'i':
            {
                const value = registers[line[1]] || 0
                registers[line[1]] = value + 1
                break;
            }
            case 'd':
            {
                const value = registers[line[1]] || 0
                registers[line[1]] = value - 1
                break;
            }
            case 'j':
            {
                let value = parseInt(line[1])
                if (isNaN(value)) {
                    value = registers[line[1]] || 0
                }
                if (value != 0) {
                    steps = parseInt(line[2])
                }
                break;
            }
        }
        index += steps
    }

    return registers['a']
}

module.exports = {
    leonardosMonorail: function(input) {
        let lines = input.split('\n')
        lines = lines.map(line => line.trim().split(' '))

        registers = {}
        const part1 = valueOfRegisterA(lines, registers)

        registers = {'c': 1 }
        const part2 = valueOfRegisterA(lines, registers)

        return [part1, part2]
    }
}
