from aoc import *
import unittest

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = smokeBasin("""2199943210
3987894921
9856789892
8767896789
9899965678""".splitlines())
        self.assertEqual(part1, 15)

unittest.main()
