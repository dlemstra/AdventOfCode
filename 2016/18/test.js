const assert = require('assert')
const aoc = require('./aoc')

let part1 = aoc.likeARogue('..^^.', 3, 3)

assert.equal(part1, 6)

part1 = aoc.likeARogue('.^^.^.^^^^', 10)

assert.equal(part1, 38)
