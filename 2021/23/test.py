import unittest
from aoc import amphipod

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = amphipod("""#############
#...........#
###B#C#B#D###
  #A#D#C#A#
  #########""".splitlines())
        self.assertEqual(part1, 12521)
        self.assertEqual(part2, 44169)

unittest.main()
