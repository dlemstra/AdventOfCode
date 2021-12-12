from aoc import *
import unittest

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = passagePathing("""start-A
start-b
A-c
A-b
b-d
A-end
b-end""".splitlines())
        self.assertEqual(part1, 10)
        self.assertEqual(part2, 36)

    def test2(self):
        (part1, part2) = passagePathing("""dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc""".splitlines())
        self.assertEqual(part1, 19)
        self.assertEqual(part2, 103)

    def test3(self):
        (part1, part2) = passagePathing("""fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW""".splitlines())
        self.assertEqual(part1, 226)
        self.assertEqual(part2, 3509)

unittest.main()
