const assert = require('assert')
const aoc = require('./aoc')

let [part1, part2] = aoc.bathroomSecurity('ULL\nRRDDD\nLURDL\nUUUUD')
assert.equal(part1, '1985')
assert.equal(part2, '5DB3')
