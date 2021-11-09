function createGrid(width, height) {
    const grid = []
        for (let y = 0; y < height; y++) {
            grid.push([])
            for (let x = 0; x < width; x++) {
                grid[y].push(' ')
            }
        }
    return grid
}

module.exports = {
    twoFactorAuthentication: function(input, width, height) {
        const grid = createGrid(width, height)
        input.split('\n').forEach(line => {
            if (line[1] == 'e') { // rect
                const info = line.split(' ')[1].split('x')
                const width = parseInt(info[0])
                const height = parseInt(info[1])
                for (let y = 0; y < height; y++) {
                    for (let x = 0; x < width; x++) {
                        grid[y][x] = '#'
                    }
                }
            } else {
                const info = line.split('=')[1].split(' ')
                const size = parseInt(info[2])
                if (line[7] == 'r') { // rotate row
                    const row = parseInt(info[0])
                    const newRow = [grid[row].length]
                    for (let x = 0; x < grid[row].length; x++) {
                        let other = x - size
                        if (other < 0) { other = grid[row].length + other }
                        newRow[x] = grid[row][other]
                    }
                    for (let x = 0; x < grid[row].length; x++) {
                        grid[row][x] = newRow[x]
                    }
                } else { // rotate column
                    const column = parseInt(info[0])
                    const newColumn = [grid.length]
                    for (let y = 0; y < grid.length; y++) {
                        let other = y - size
                        if (other < 0) { other = grid.length + other }
                        newColumn[y] = grid[other][column]
                    }
                    for (let y = 0; y < grid.length; y++) {
                        grid[y][column] = newColumn[y]
                    }
                }
            }
        })

        let lit = 0
        for (let y = 0; y < grid.length; y++) {
            lit += grid[y].filter(c => c == '#').length
        }

        return lit
    }
}
