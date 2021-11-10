const assert = require('assert')
const aoc = require('./aoc')

let part1 = aoc.explosivesInCyberspace(`ADVENT
A(1x5)BC
(3x3)XYZ
(6x1)(1x3)A
X(8x2)(3x3)ABCY`)

assert.equal(part1, 46)
