const assert = require('assert')
const aoc = require('./aoc')

let [part1, part2] = aoc.timingIsEverything(`Disc #1 has 5 positions; at time=0, it is at position 4.
Disc #2 has 2 positions; at time=0, it is at position 1.`)

assert.equal(part1, 5)
assert.equal(part2, 85)
