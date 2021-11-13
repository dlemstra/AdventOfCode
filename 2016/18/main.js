const fs = require('fs')
const aoc = require('./aoc')

const input = fs.readFileSync('input', 'utf8')

let part1 = aoc.likeARogue(input, 40)
let part2 = aoc.likeARogue(input, 400000)
console.log('Part 1:', part1)
console.log('Part 2:', part2)
