const assert = require('assert')
const aoc = require('./aoc')

let [part1, a] = aoc.explosivesInCyberspace(`ADVENT
A(1x5)BC
(3x3)XYZ
(6x1)(1x3)A
X(8x2)(3x3)ABCY`)

assert.equal(part1, 46)

let [b, part2] = aoc.explosivesInCyberspace(`(3x3)XYZ
X(8x2)(3x3)ABCY
(27x12)(20x12)(13x14)(7x10)(1x12)A
(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN`)

assert.equal(part2, 242394)