function isTrap(type1, type2, type3) {
    const type = `${type1}${type2}${type3}`
    return type == '^^.' || type == '.^^' || type == '^..' || type == '..^'
}

module.exports = {
    likeARogue: function(input, count) {
        let rows = [input.trim()]

        while (rows.length != count) {
            let newRow = ''
            const previousRow = rows[rows.length - 1]
            for (let i = 0; i < previousRow.length; i++) {
                const type1 = (i == 0) ? '.' : previousRow[i - 1]
                const type2 = previousRow[i]
                const type3 = (i == previousRow.length - 1) ? '.' : previousRow[i + 1]

                newRow += isTrap(type1, type2, type3) ? '^' : '.'
            }
            rows.push(newRow)
        }

        let safeTiles = 0
        rows.forEach(row => {
            safeTiles += row.split('').filter(tile => tile == '.').length
        })

        return safeTiles
    }
}
