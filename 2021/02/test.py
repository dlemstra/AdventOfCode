from aoc import *
import unittest

class TestAoc(unittest.TestCase):

    def test(self):
        part1 = dive("""forward 5
down 5
forward 8
up 3
down 8
forward 2""".splitlines())
        self.assertEqual(part1, 150)

unittest.main()
