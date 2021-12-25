import unittest
from aoc import seaCucumber

class TestAoc(unittest.TestCase):

    def test(self):
        part1 = seaCucumber("""v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>""".splitlines())
        self.assertEqual(part1, 58)

unittest.main()
