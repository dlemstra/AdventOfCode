function checkNumbers(a, b, c) {
    return a + b > c &&
        a + c > b &&
        b + c > a
}

module.exports = {
    squaresWithThreeSides: function(input) {
        let correct1 = 0
        let correct2 = 0
        let rows = []
        input.split('\n').forEach((line) => {
            const numbers = line.split(' ').filter(n => n).map(n => parseInt(n))
            if (checkNumbers(numbers[0], numbers[1], numbers[2])) { correct1++ }

            rows.push(numbers)
            if (rows.length == 3) {
                if (checkNumbers(rows[0][0], rows[1][0], rows[2][0])) { correct2++ }
                if (checkNumbers(rows[0][1], rows[1][1], rows[2][1])) { correct2++ }
                if (checkNumbers(rows[0][2], rows[1][2], rows[2][2])) { correct2++ }

                rows = []
            }
        })

        return [correct1, correct2]
    }
}
