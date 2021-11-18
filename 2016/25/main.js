const fs = require('fs')
const aoc = require('./aoc')

const input = fs.readFileSync('input', 'utf8')

const part1 = aoc.lockSignal(input)
console.log('Part 1:', part1)
