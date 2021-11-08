const fs = require('fs')
const aoc = require('./aoc')

const input = fs.readFileSync('input', 'utf8')

console.log(aoc.noTimeForATaxicab(input))
