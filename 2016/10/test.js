const assert = require('assert')
const aoc = require('./aoc')

let [part1, part2] = aoc.balanceBots(`value 5 goes to bot 2
bot 2 gives low to bot 1 and high to bot 0
value 3 goes to bot 1
bot 1 gives low to output 1 and high to bot 0
bot 0 gives low to output 2 and high to output 0
value 2 goes to bot 2`, 2, 5, [0, 1, 2])

assert.equal(part1, 2)
assert.equal(part2, 30)
