function combinations(n, k) {
    let result= [];

    function recurse(start, combos) {
        if (combos.length === k) {
            return result.push(combos.slice());
        }

        if (combos.length + (n - start + 1) < k){
            return;
        }

        recurse(start + 1, combos);
        combos.push(start);
        recurse(start + 1, combos);
        combos.pop();
    }

    recurse(1, []);
    return result;
}

class Microchip {
    constructor(element) {
        this.name = `${element.toUpperCase()}M`
    }

    element() { return this.name[0] }
    type() { return this.name[1] }
}

class Generator {
    constructor(element) {
        this.name = `${element.toUpperCase()}G`
    }

    element() { return this.name[0] }
    type() { return this.name[1] }
}

class State {
    constructor(floors, level, steps) {
        this.floors = floors.map(floor => [...floor])
        this.level = level
        this.steps = steps

        this.history = []
    }

    copy() { return new State(this.floors, this.level, this.steps) }

    done() {
        for (let i=0; i < this.floors.length - 1; i++) {
            if (this.floors[i].length != 0) { return false }
        }

        return true
    }

    newStates() {
        return this.getNewStates(this.level + 1).concat(this.getNewStates(this.level - 1))
    }

    getNewStates(level) {
        if (level < 0 || level == this.floors.length ) { return [] }

        const newStates = []

        const currentFloor = this.floors[this.level];

        for (let i = 0; i < currentFloor.length; i++) {
            const newState = this.copy()
            const item = newState.floors[this.level][i]

            newState.floors[this.level].splice(i, 1)
            newState.floors[level].push(item)

            if (newState.isValidFloor(this.level) && newState.isValidFloor(level)) {
                newState.steps++
                newState.level = level
                newStates.push(newState)
            }
        }

        if (currentFloor.length > 1) {
            const options = combinations(currentFloor.length, 2)
            for (let i=0; i < options.length; i++) {
                options[i].sort((a, b) => a - b)

                const newState = this.copy()
                const indexA = options[i][0] - 1;
                const optionA = newState.floors[this.level][indexA]
                const indexB = options[i][1] - 1
                const optionB = newState.floors[this.level][indexB]

                newState.floors[this.level].splice(indexB, 1)
                newState.floors[this.level].splice(indexA, 1)
                newState.floors[level].push(optionA)
                newState.floors[level].push(optionB)

                if (newState.isValidFloor(this.level) && newState.isValidFloor(level)) {
                    newState.steps++
                    newState.level = level
                    newStates.push(newState)
                }
            }
        }

        return newStates
    }

    checksum() {
        const floorNames = []

        for (let i=0; i < this.floors.length; i++) {
            const names = this.floors[i].map(item => item.name)
            names.sort()

            floorNames.push(names.join('+'))
        }

        return `${this.level+1}:${floorNames.join(',')}`
    }

    isValidFloor(level) {
        const microchips = this.floors[level].filter(item => item.type() == 'M')
        const generators = this.floors[level].filter(item => item.type() == 'G')

        if (generators.length == 0) { return true; }

        for (let i = 0; i < generators.length; i++) {
            for (let j = 0; j < microchips.length; j++) {
                if (generators[i].element() == microchips[j].element()) {
                    microchips.splice(j, 1)
                    break
                }
            }
        }

        return microchips.length == 0
    }
}

module.exports = {
    radioisotopeThermoelectricGenerators : function(input) {
        const floors = []

        input.split('\n').forEach((line) => {
            const floor = []
            const info = line.trim().split(' ');
            for (let i=0; i < info.length; i++) {
                if (info[i] == 'a') {
                    if (info[i + 2][0] == 'm') {
                        floor.push(new Microchip(info[i + 1][0]))
                    } else {
                        floor.push(new Generator(info[i + 1][0]))
                    }
                }
            }
            floors.push(floor)
        })

        const startState = new State(floors, 0, 0)

        const checksums = {}
        checksums[startState.checksum()] = 1

        const states = []
        states.push(startState)

        let leastSteps = 1000000
        while (states.length > 0) {
            const state = states[0]
            states.splice(0, 1)

            state.newStates().forEach(newState => {
                const checksum = newState.checksum()
                if (!checksums[checksum] || newState.steps < checksums[checksum]) {
                    newState.history.push()
                    checksums[checksum] = newState.steps
                    if (newState.done()) {
                        leastSteps = Math.min(newState.steps, leastSteps)
                    } else {
                        states.push(newState)
                    }
                }
            })
        }

        return leastSteps
    }
}
