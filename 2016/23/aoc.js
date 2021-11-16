function initRegister(registers, register) {
    if (!registers[register]) { registers[register] = 0 }
}

function getValue(registers, valueOrRegister) {
    const number = parseInt(valueOrRegister)
    if (!isNaN(number)) { return number }
    initRegister(registers, valueOrRegister)
    return registers[valueOrRegister]
}

class Cpy {
    constructor(valueOrRegister, target) {
        this.valueOrRegister = valueOrRegister
        this.target = target
    }

    execute(registers, instructions, index) {
        if (isNaN(parseInt(this.target))) {
            const value = getValue(registers, this.valueOrRegister)
            registers[this.target] = value
        }

        return index + 1
    }

    toggle() { return new Jnz(this.valueOrRegister, this.target) }
}

class Dec {
    constructor(register) {
        this.register = register
    }

    execute(registers, instructions, index) {
        initRegister(registers, this.register)
        registers[this.register]--

        return index + 1
    }

    toggle() { return new Inc(this.register) }
}

class Inc {
    constructor(register) {
        this.register = register
    }

    execute(registers, instructions, index) {
        initRegister(registers, this.register)
        registers[this.register]++

        return index + 1
    }

    toggle() { return new Dec(this.register) }
}

class Jnz {
    constructor(valueOrRegister, stepsOrRegister) {
        this.valueOrRegister = valueOrRegister
        this.stepsOrRegister = stepsOrRegister
    }

    execute(registers, instructions, index) {
        const value = getValue(registers, this.valueOrRegister)
        if (value == 0) {
            return index + 1
        }

        const steps = getValue(registers, this.stepsOrRegister)
        return index + steps
    }

    toggle() { return new Cpy(this.valueOrRegister, this.stepsOrRegister) }
}

class Tgl {
    constructor(valueOrRegister) {
        this.valueOrRegister = valueOrRegister
    }

    execute(registers, instructions, index) {
        const value = getValue(registers, this.valueOrRegister)
        const targetIndex = index + value
        if (targetIndex >= 0 && targetIndex < instructions.length) {
            instructions[targetIndex] = instructions[targetIndex].toggle()
        }

        return index + 1
    }

    toggle() { return new Inc(this.valueOrRegister) }
}

module.exports = {
    safeCracking: function(input, initialValue) {
        const registers = {}
        registers['a'] = initialValue

        const instructions = []

        input.split('\n').forEach(line => {
            const info = line.trim().split(' ')
            const arg1 = info[1]
            const arg2 = info[2]
            switch(info[0]) {
                case 'cpy':
                    instructions.push(new Cpy(arg1, arg2))
                    break;
                case 'dec':
                    instructions.push(new Dec(arg1))
                    break;
                case 'inc':
                    instructions.push(new Inc(arg1))
                    break;
                case 'jnz':
                    instructions.push(new Jnz(arg1, arg2))
                    break;
                case 'tgl':
                    instructions.push(new Tgl(arg1))
                    break;
            }
        });

        let index = 0
        while (index >= 0 && index < instructions.length) {
            index = instructions[index].execute(registers, instructions, index)
        }

        return registers['a']
    }
}
