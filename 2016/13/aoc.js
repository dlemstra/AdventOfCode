function bitCount(n) {
    n = n - ((n >> 1) & 0x55555555)
    n = (n & 0x33333333) + ((n >> 2) & 0x33333333)
    return ((n + (n >> 4) & 0xF0F0F0F) * 0x1010101) >> 24
}

function isOpenSpace(number, x, y) {
    if (x < 0 || y < 0) { return false }
    const total = (x*x + 3*x + 2*x*y + y + y*y) + number
    return bitCount(total) % 2 == 0
}

function checkPosition(positions, number, x, y, steps) {
    if (isOpenSpace(number, x, y)) { positions.push(new Position(x, y, steps)) }
}

class Position {
    constructor(x, y, steps) {
        this.x = x
        this.y = y
        this.steps = steps
    }
}

module.exports = {
    aMazeOfTwistyLittleCubicles: function(input, x, y) {
        const number = parseInt(input)

        const stepCount = { }
        const start = new Position(1, 1, 0)

        const positions = [start]
        while (positions.length > 0) {
            const position = positions.pop()

            if (position.x > x + 10 && position.y > y + 10) {
                continue
            }

            const key = `${position.x}x${position.y}`
            if (stepCount[key] && stepCount[key] < position.steps) {
                continue
            } else {
                stepCount[key] = position.steps

                checkPosition(positions, number, position.x + 0, position.y + 1, position.steps + 1)
                checkPosition(positions, number, position.x + 0, position.y - 1, position.steps + 1)
                checkPosition(positions, number, position.x + 1, position.y + 0, position.steps + 1)
                checkPosition(positions, number, position.x - 1, position.y + 0, position.steps + 1)
            }
        }

        return stepCount[`${x}x${y}`]
    }
}
