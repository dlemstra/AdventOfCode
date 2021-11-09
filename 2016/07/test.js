const assert = require('assert')
const aoc = require('./aoc')

let part1 = aoc.internetProtocolVersion7(`abba[mnop]qrst
abcd[bddb]xyyx
aaaa[qwer]tyui
ioxxoj[asdfgh]zxcvbn`)
assert.equal(part1, 2)
