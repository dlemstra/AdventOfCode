module.exports = {
    squaresWithThreeSides: function(input) {
        let correct = 0
        input.split('\n').forEach((line) => {
            const numbers = line.split(' ').filter(n => n).map(n => parseInt(n))
            if (numbers[0] + numbers[1] > numbers[2] &&
                numbers[0] + numbers[2] > numbers[1] &&
                numbers[1] + numbers[2] > numbers[0]) { correct++ }
        })

        return correct
    }
}
