import unittest
from aoc import packetDecoder

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, part2) = packetDecoder("8A004A801A8002F478".splitlines())
        self.assertEqual(part1, 16)

    def test2(self):
        (part1, part2) = packetDecoder("620080001611562C8802118E34".splitlines())
        self.assertEqual(part1, 12)

    def test3(self):
        (part1, part2) = packetDecoder("C0015000016115A2E0802F182340".splitlines())
        self.assertEqual(part1, 23)

    def test4(self):
        (part1, part2) = packetDecoder("A0016C880162017C3686B18A3D4780".splitlines())
        self.assertEqual(part1, 31)

unittest.main()
