from aoc import *
import unittest

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = lanternfish("3,4,3,1,2".splitlines())
        self.assertEqual(part1, 5934)

unittest.main()
