const assert = require('assert')
const aoc = require('./aoc')

let part1 = aoc.gridComputing(`root@ebhq-gridcenter# df -h
Filesystem              Size  Used  Avail  Use%
/dev/grid/node-x0-y0     92T    0T    19T   79%
/dev/grid/node-x0-y1     91T   10T    25T   72%
/dev/grid/node-x0-y2     85T   73T    12T   85%`)

assert.equal(part1, 2)
