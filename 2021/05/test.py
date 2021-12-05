from aoc import *
import unittest

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = hydrothermalVenture("""0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2""".splitlines())
        self.assertEqual(part1, 5)
        self.assertEqual(part2, 12)

unittest.main()
