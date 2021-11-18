const assert = require('assert')
const aoc = require('./aoc')

let part1 = aoc.airDuctSpelunking(`###########
#0.1.....2#
#.#######.#
#4.......3#
###########`)

assert.equal(part1, 14)
