from aoc import *
import unittest

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = dumboOctopus("""5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526""".splitlines())
        self.assertEqual(part1, 1656)

unittest.main()
