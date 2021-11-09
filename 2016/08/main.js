const fs = require('fs')
const aoc = require('./aoc')

const input = fs.readFileSync('input', 'utf8')

function printGrid(grid) {
    for (let y = 0; y < grid.length; y++) {
        console.log(grid[y].join(''))
    }
    console.log()
}

let [part1, grid] = aoc.twoFactorAuthentication(input, 50, 6)
console.log('Part 1:', part1)
printGrid(grid)
