from aoc import *
import unittest

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = sonarSweep("""199
200
208
210
200
207
240
269
260
263""".splitlines())
        self.assertEqual(part1, 7)
        self.assertEqual(part2, 5)

unittest.main()
