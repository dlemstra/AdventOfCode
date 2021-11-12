const assert = require('assert')
const aoc = require('./aoc')

let [part1, part2] = aoc.oneTimePad('abc')

assert.equal(part1, 22728)
assert.equal(part2, 22551)
