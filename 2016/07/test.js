const assert = require('assert')
const aoc = require('./aoc')

let [part1_1, part2_1] = aoc.internetProtocolVersion7(`abba[mnop]qrst
abcd[bddb]xyyx
aaaa[qwer]tyui
ioxxoj[asdfgh]zxcvbn`)
assert.equal(part1_1, 2)
assert.equal(part2_1, 0)

let [part1_2, part2_2] = aoc.internetProtocolVersion7(`aba[bab]xyz
xyx[xyx]xyx
aaa[kek]eke
zazbz[bzb]cdb`)
assert.equal(part1_2, 0)
assert.equal(part2_2, 3)
