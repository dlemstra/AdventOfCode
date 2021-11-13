const assert = require('assert')
const aoc = require('./aoc')

let part1 = aoc.firewallRules(`5-8
0-2
4-7`)

assert.equal(part1, 3)
