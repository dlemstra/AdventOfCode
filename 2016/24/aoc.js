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

function permutator(inputArr) {
    var results = []

    function permute(arr, memo) {
      var cur, memo = memo || []

      for (var i = 0; i < arr.length; i++) {
        cur = arr.splice(i, 1)
        if (arr.length === 0) {
          results.push(memo.concat(cur))
        }
        permute(arr.slice(), memo.concat(cur))
        arr.splice(i, 0, cur[0])
      }

      return results
    }

    return permute(inputArr)
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

        let part1 = Number.MAX_VALUE
        let part2 = Number.MAX_VALUE
        const allSteps = permutator(numbers).filter(array => array[0].value == 0)
        for (let i=0; i < allSteps.length; i++) {
            const steps = allSteps[i]
            let total = 0
            for (let j=1; j < steps.length; j++) {
                total += stepCounts[`${steps[j-1].value}-${steps[j].value}`]
            }

            part1 = Math.min(part1, total)
            part2 = Math.min(part2, total + stepCounts[`${steps[steps.length-1].value}-0`])
        }

        return [part1, part2]
    }
}
