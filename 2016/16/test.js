const assert = require('assert')
const aoc = require('./aoc')

let part1 = aoc.dragonChecksum('110010110100', 12)

assert.equal(part1, '100')

part1 = aoc.dragonChecksum('10000', 20)

assert.equal(part1, '01100')
