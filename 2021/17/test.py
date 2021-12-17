import unittest
from aoc import trickShot

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = trickShot("""target area: x=20..30, y=-10..-5""".splitlines())
        self.assertEqual(part1, 45)
        self.assertEqual(part2, 112)

unittest.main()
