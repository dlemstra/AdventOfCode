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

module.exports = {
    scrambledLettersAndHash: function(start, input) {
        let result = start.split('')
        input.split('\n').forEach(line => {
            const info = line.trim().split(' ')
            if (info[0][0] == 's') { // swap
                if (info[1][0] == 'p') { // position
                    const positions = [parseInt(info[2]), parseInt(info[5])]
                    swapPositions(result, positions)
                } else { // letter
                    const positions = [result.indexOf(info[2]), result.indexOf(info[5])]
                    swapPositions(result, positions)
                }
            } else if (info[0][0] == 'r') {
                if (info[0][1] == 'e') { // reverse
                    const start = parseInt(info[2])
                    const end = parseInt(info[4]) + 1
                    reverse(result, start, end - start)
                } else { // rotate
                    if (info[1][0] == 'b') { // based
                        let count = result.indexOf(info[6]) + 1
                        if (count > 4) { count++ }
                        count = count % result.length
                        rotate(result, count, true)
                    } else {
                        const right = info[1][0] == 'r'
                        const count = parseInt(info[2])
                        rotate(result, count, right)
                    }
                }
            } else if (info[0][0] == 'm') { // move
                const positions = [parseInt(info[2]), parseInt(info[5])]
                moveValues(result, positions)
            }
        })

        return result.join('')
    }
}
