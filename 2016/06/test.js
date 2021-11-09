const assert = require('assert')
const aoc = require('./aoc')

let [part1, part2] = aoc.signalsAndNoise(`eedadn
drvtee
eandsr
raavrd
atevrs
tsrnev
sdttsa
rasrtv
nssdts
ntnada
svetve
tesnvt
vntsnd
vrdear
dvrsen
enarar`)
assert.equal(part1, 'easter')
assert.equal(part2, 'advent')
