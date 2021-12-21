import unittest
from aoc import diracDice

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = diracDice("""Player 1 starting position: 4
Player 2 starting position: 8""".splitlines())
        self.assertEqual(part1, 739785)
        self.assertEqual(part2, 444356092776315)

unittest.main()
