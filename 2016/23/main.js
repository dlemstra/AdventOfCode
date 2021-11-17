const fs = require('fs')
const aoc = require('./aoc')

const input = fs.readFileSync('input', 'utf8')

let part1 = aoc.safeCracking(input, 7)
console.log('Part 1:', part1)

// Completes in 4 minutes but still faster than optimizing it
let part2 = aoc.safeCracking(input, 12)
console.log('Part 2:', part2)
