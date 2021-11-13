const assert = require('assert')
const aoc = require('./aoc')

let part1_1 = aoc.likeARogue('..^^.', 3)

assert.equal(part1_1, 6)

let part1_2 = aoc.likeARogue('.^^.^.^^^^', 10)

assert.equal(part1_2, 38)
