const assert = require('assert')
const aoc = require('./aoc')

let [part1, grid] = aoc.twoFactorAuthentication(`rect 3x2
rotate column x=1 by 1
rotate row y=0 by 4
rotate column x=1 by 1`, 7, 3)

assert.equal(part1, 6)
