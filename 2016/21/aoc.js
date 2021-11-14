function swapPositions(array, positions) {
    positions.sort((a, b) => a - b)
    const a = array[positions[0]]
    const b = array.splice(positions[1], 1)[0]
    array.splice(positions[1], 0, a)
    array.splice(positions[0], 1)
    array.splice(positions[0], 0, b)
}

function moveValues(array, positions) {
    const a = array.splice(positions[0], 1)[0]
    array.splice(positions[1], 0, a)
}

function reverse(array, index, length) {
    const part = array.slice(index, index + length)
    part.reverse()

    for (let i = 0, j = index; i < part.length, j < index + length; i++, j++) {
        array[j] = part[i]
    }
}

function rotate(array, count, right) {
    if (count == 0) { return }

    const tail = right ? array.splice(0, array.length - count) : array.splice(0, count)
    for (let i = 0; i < tail.length; i++) {
        array.push(tail[i])
    }
}

function permutations(array) {
    let result = []

    for (let i = 0; i < array.length; i++) {
        let rest = permutations(array.slice(0, i).concat(array.slice(i + 1)))

        if (!rest.length) {
            result.push([array[i]])
        } else {
            for(let j = 0; j < rest.length; j++) {
                result.push([array[i]].concat(rest[j]))
            }
        }
    }

    return result
}

function parseInstructions(array, input) {
    input.split('\n').forEach(line => {
        const info = line.trim().split(' ')
        if (info[0][0] == 's') { // swap
            if (info[1][0] == 'p') { // position
                const positions = [parseInt(info[2]), parseInt(info[5])]
                swapPositions(array, positions)
            } else { // letter
                const positions = [array.indexOf(info[2]), array.indexOf(info[5])]
                swapPositions(array, positions)
            }
        } else if (info[0][0] == 'r') {
            if (info[0][1] == 'e') { // reverse
                const start = parseInt(info[2])
                const end = parseInt(info[4]) + 1
                reverse(array, start, end - start)
            } else { // rotate
                if (info[1][0] == 'b') { // based
                    let count = array.indexOf(info[6]) + 1
                    if (count > 4) { count++ }
                    count = count % array.length
                    rotate(array, count, true)
                } else {
                    const right = info[1][0] == 'r'
                    const count = parseInt(info[2])
                    rotate(array, count, right)
                }
            }
        } else if (info[0][0] == 'm') { // move
            const positions = [parseInt(info[2]), parseInt(info[5])]
            moveValues(array, positions)
        }
    })

    return array.join('')
}

module.exports = {
    scrambledLettersAndHash: function(input, start, scrambled) {
        const array = start.split('')

        const part1 =  parseInstructions([...array], input)

        let part2 = ''
        if (scrambled) {
            const values = permutations(array)
            for (let i = 0; i < values.length; i++) {
                const result = parseInstructions([...values[i]], input)
                if (result == scrambled) {
                    part2 = values[i].join('')
                    break
                }
            }
        }

        return [part1, part2]
    }
}
