const assert = require('assert')
const aoc = require('./aoc')

let [part1, part2] = aoc.airDuctSpelunking(`###########
#0.1.....2#
#.#######.#
#4.......3#
###########`)

assert.equal(part1, 14)
assert.equal(part2, 20)
