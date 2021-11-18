class Position {
    constructor(x, y, steps) {
        this.x = x
        this.y = y
        this.steps = steps ? steps : 0
    }
}

class Num {
    constructor(x, y, value) {
        this.x = x
        this.y = y
        this.value = value
    }
}

function combinations(n, k) {
    let result = []

    function recurse(start, combos) {
        if (combos.length === k) {
            return result.push(combos.slice())
        }

        if (combos.length + (n - start + 1) < k){
            return
        }

        recurse(start + 1, combos)
        combos.push(start)
        recurse(start + 1, combos)
        combos.pop()
    }

    recurse(0, [])
    return result
}

function getMinimalSteps(walls, startX, startY, endX, endY) {
    const stepCount = {}
    const positions = [new Position(startX, startY)]

    while (positions.length > 0) {
        const position = positions.splice(0, 1)[0]

        const key = `${position.x}x${position.y}`
        if (stepCount[key] && position.steps >= stepCount[key]) {
            continue
        } else {
            stepCount[key] = position.steps

            if (position.x == endX && position.y == endY) { continue }

            const newPositions = [
                new Position(position.x + 1, position.y + 0, position.steps + 1),
                new Position(position.x - 1, position.y + 0, position.steps + 1),
                new Position(position.x + 0, position.y + 1, position.steps + 1),
                new Position(position.x + 0, position.y - 1, position.steps + 1)
            ]
            for (let i=0; i < newPositions.length; i++) {
                const newPosition = newPositions[i]
                if (walls[`${newPosition.x}x${newPosition.y}`]) { continue }

                positions.push(newPosition)
            }
        }
    }

    return stepCount[`${endX}x${endY}`]
}

function getTotalSteps(stepCounts, startNumber, array) {
    const starts = array.filter(key => key.startsWith(`${startNumber}-`))
    const remaining = array.filter(v => !(v.startsWith(`${startNumber}-`) || v.endsWith(`-${startNumber}`)))

    let bestTotal = -1
    for (let i=0; i < starts.length; i++) {
        let total = stepCounts[starts[i]]
        if (remaining.length > 0) {
            let number = starts[i].split('-')[1]
            total += getTotalSteps(stepCounts, number, remaining)
        }
        if (bestTotal == -1 || total < bestTotal) { bestTotal = total }
    }

    return bestTotal
}

module.exports = {
    airDuctSpelunking: function(input) {
        const walls = {}
        const numbers = []

        let y = 0
        input.split('\n').forEach(line => {
            let x = 0
            line.trim().split('').forEach(char => {
                if (char == '#') { walls[`${x}x${y}`] = 1 }
                else if (char != '.') { numbers.push(new Num(x, y, parseInt(char))) }
                x++
            });
            y++
        });

        const stepCounts = {}

        const options = combinations(numbers.length - 1, 2)
        options.forEach(option => {
            const numberA = numbers[option[0]]
            const numberB = numbers[option[1]]

            const steps = getMinimalSteps(walls, numberA.x, numberA.y, numberB.x, numberB.y)
            stepCounts[`${numberA.value}-${numberB.value}`] = steps
            stepCounts[`${numberB.value}-${numberA.value}`] = steps
        })

        return getTotalSteps(stepCounts, 0, Object.keys(stepCounts))
    }
}
