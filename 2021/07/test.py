from aoc import *
import unittest

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = theTreacheryOfWhales("16,1,2,0,4,2,7,1,2,14".splitlines())
        self.assertEqual(part1, 37)

unittest.main()
