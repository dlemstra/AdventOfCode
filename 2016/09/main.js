const fs = require('fs')
const aoc = require('./aoc')

const input = fs.readFileSync('input', 'utf8')

let [part1, part2] = aoc.explosivesInCyberspace(input)
console.log('Part 1:', part1)
console.log('Part 2:', part2)
