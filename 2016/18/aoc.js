function isTrap(type1, type3) {
    if (type1 == '^') { return type3 == '.' }
    if (type3 == '^') { return type1 == '.' }
    return false
}

module.exports = {
    likeARogue: function(input, count) {
        let previousRow = input.trim()

        let safeTiles = previousRow.split('').filter(tile => tile == '.').length

        let row = 0
        while (++row != count) {
            let newRow = ''
            for (let i = 0; i < previousRow.length; i++) {
                const type1 = (i == 0) ? '.' : previousRow[i - 1]
                const type3 = (i == previousRow.length - 1) ? '.' : previousRow[i + 1]

                if (isTrap(type1, type3)) {
                    newRow += '^'
                } else {
                    newRow += '.'
                    safeTiles++
                }
            }
            previousRow = newRow
        }

        return safeTiles
    }
}
