const assert = require('assert')
const aoc = require('./aoc')

let [part1_1, part2_1] = aoc.twoStepsForward('ihgpwlah')

assert.equal(part1_1, 'DDRRRD')
assert.equal(part2_1, 370)

let [part1_2, part2_2] = aoc.twoStepsForward('kglvqrro')

assert.equal(part1_2, 'DDUDRLRRUDRD')
assert.equal(part2_2, 492)

let [part1_3, part2_3] = aoc.twoStepsForward('ulqzkmiv')

assert.equal(part1_3, 'DRURDRUDDLLDLUURRDULRLDUUDDDRR')
assert.equal(part2_3, 830)
