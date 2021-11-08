const assert = require('assert')
const aoc = require('./aoc')

let [part1_1, part2_1] = aoc.noTimeForATaxicab('R2, L3')
assert.equal(part1_1, 5)
assert.equal(part2_1, 0)

let [part1_2, part2_2] = aoc.noTimeForATaxicab('R2, R2, R2')
assert.equal(part1_2, 2)
assert.equal(part2_2, 0)

let [part1_3, part2_3] = aoc.noTimeForATaxicab('R5, L5, R5, R3')
assert.equal(part1_3, 12)
assert.equal(part2_3, 0)

let [part1_4, part2_4] = aoc.noTimeForATaxicab('R8, R4, R4, R8')
assert.equal(part1_4, 8)
assert.equal(part2_4, 4)
