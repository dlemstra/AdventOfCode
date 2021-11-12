const assert = require('assert')
const aoc = require('./aoc')

let [part1, part2] = aoc.leonardosMonorail(`cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a`)

assert.equal(part1, 42)
assert.equal(part2, 42)
