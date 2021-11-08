const assert = require('assert')
const aoc = require('./aoc')

let [part1, part2] = aoc.squaresWithThreeSides('5 10 25\n7 11 16\n3 14 15')
assert.equal(part1, 2)
assert.equal(part2, 3)
