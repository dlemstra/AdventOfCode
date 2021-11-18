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

    execute(registers, index) {
        if (isNaN(parseInt(this.target))) {
            const value = getValue(registers, this.valueOrRegister)
            registers[this.target] = value
        }

        return index + 1
    }
}

class Dec {
    constructor(register) {
        this.register = register
    }

    execute(registers, index) {
        initRegister(registers, this.register)
        registers[this.register]--

        return index + 1
    }
}

class Inc {
    constructor(register) {
        this.register = register
    }

    execute(registers, index) {
        initRegister(registers, this.register)
        registers[this.register]++

        return index + 1
    }
}

class Jnz {
    constructor(valueOrRegister, stepsOrRegister) {
        this.valueOrRegister = valueOrRegister
        this.stepsOrRegister = stepsOrRegister
    }

    execute(registers, index) {
        const value = getValue(registers, this.valueOrRegister)
        if (value == 0) {
            return index + 1
        }

        const steps = getValue(registers, this.stepsOrRegister)
        return index + steps
    }
}

class Out {
    constructor(register) {
        this.register = register
        this.value = 1
        this.count = 0
    }

    execute(registers, index) {
        const value = getValue(registers, this.register)
        if (value < 0 || value > 1 || value == this.value) {
            return -1
        } else {
            if (++this.count == 1000) { return -1 }
            this.value = value
            return index + 1
        }
    }
}

function testValueA(instructions, valueA) {
    const registers = {}
    registers['a'] = valueA

    let index = 0
    while (index >= 0 && index < instructions.length) {
        index = instructions[index].execute(registers, index)
    }
}

module.exports = {
    lockSignal: function(input) {
        let infos = input.split('\n').map(line => line.trim().split(' '))
        let instructions = []

        let outIndex = 0
        for (let i=0; i < infos.length; i++) {
            const info = infos[i]
            const arg1 = info[1]
            const arg2 = info[2]
            switch(info[0]) {
                case 'cpy':
                    instructions.push(new Cpy(arg1, arg2))
                    break
                case 'dec':
                    instructions.push(new Dec(arg1))
                    break
                case 'inc':
                    instructions.push(new Inc(arg1))
                    break
                case 'out':
                    instructions.push(new Out(arg1, arg2))
                    outIndex = i
                    break
                case 'jnz':
                    instructions.push(new Jnz(arg1, arg2))
                    break
            }
        }

        let valueA = 0
        while (valueA >= 0) {
            instructions[outIndex].count = 0
            instructions[outIndex].value = 1
            testValueA(instructions, ++valueA)
            if (instructions[outIndex].count == 1000) { break }
        }

        return valueA
    }
}
