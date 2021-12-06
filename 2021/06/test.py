from aoc import *
import unittest

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = lanternfish("3,4,3,1,2".splitlines())
        self.assertEqual(part1, 5934)
        self.assertEqual(part2, 26984457539)

unittest.main()
