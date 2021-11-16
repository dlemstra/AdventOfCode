const assert = require('assert')
const aoc = require('./aoc')

let part1 = aoc.safeCracking(`cpy 2 a
tgl a
tgl a
tgl a
cpy 1 a
dec a
dec a`)

assert.equal(part1, 3)
