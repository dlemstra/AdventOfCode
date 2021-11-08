const assert = require('assert')
const aoc = require('./aoc')

let result = aoc.noTimeForATaxicab('R2, L3')
assert.equal(result, 5)

result = aoc.noTimeForATaxicab('R2, R2, R2')
assert.equal(result, 2)

result = aoc.noTimeForATaxicab('R5, L5, R5, R3')
assert.equal(result, 12)
