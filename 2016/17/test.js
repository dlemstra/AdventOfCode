const assert = require('assert')
const aoc = require('./aoc')

let part1_1 = aoc.twoStepsForward('ihgpwlah')

assert.equal(part1_1, 'DDRRRD')

let part1_2 = aoc.twoStepsForward('kglvqrro')

assert.equal(part1_2, 'DDUDRLRRUDRD')

let part1_3 = aoc.twoStepsForward('ulqzkmiv')

assert.equal(part1_3, 'DRURDRUDDLLDLUURRDULRLDUUDDDRR')
