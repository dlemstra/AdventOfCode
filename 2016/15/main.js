const fs = require('fs')
const aoc = require('./aoc')

const input = fs.readFileSync('input', 'utf8')

let part1 = aoc.timingIsEverything(input)
console.log('Part 1:', part1)
