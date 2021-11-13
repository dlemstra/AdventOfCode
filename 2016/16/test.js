const assert = require('assert')
const aoc = require('./aoc')

let [part1_1, part2_1] = aoc.dragonChecksum('110010110100', 12, 12)

assert.equal(part1_1, '100')
assert.equal(part2_1, '100')

let [part1_2, part2_2] = aoc.dragonChecksum('10000', 20, 20)

assert.equal(part1_2, '01100')
assert.equal(part2_2, '01100')
