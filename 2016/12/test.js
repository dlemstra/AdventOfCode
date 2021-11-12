const assert = require('assert')
const aoc = require('./aoc')

let part1 = aoc.leonardosMonorail(`cpy 41 a
inc a
inc a
dec a
jnz a 2
dec a`)

assert.equal(part1, 42)
