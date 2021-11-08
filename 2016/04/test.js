const assert = require('assert')
const aoc = require('./aoc')

let [part1, part2] = aoc.securityThroughObscurity(`aaaaa-bbb-z-y-x-123[abxyz]
a-b-c-d-e-f-g-h-987[abcde]
not-a-real-room-404[oarel]
totally-real-room-200[decoy]`)
assert.equal(part1, 1514)
