from aoc import *
import unittest

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = binaryDiagnostic("""00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010""".splitlines())
        self.assertEqual(part1, 198)
        self.assertEqual(part2, 230)

unittest.main()
