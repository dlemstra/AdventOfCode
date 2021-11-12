const assert = require('assert')
const aoc = require('./aoc')

let [part1, part2] = aoc.aMazeOfTwistyLittleCubicles('10', 7, 4)

assert.equal(part1, 11)
assert.equal(part2, 134)
