import unittest
from aoc import packetDecoder

class TestAoc(unittest.TestCase):

    def test(self):
        (part1, _) = packetDecoder("8A004A801A8002F478".splitlines())
        self.assertEqual(part1, 16)

    def test2(self):
        (part1, _) = packetDecoder("620080001611562C8802118E34".splitlines())
        self.assertEqual(part1, 12)

    def test3(self):
        (part1, _) = packetDecoder("C0015000016115A2E0802F182340".splitlines())
        self.assertEqual(part1, 23)

    def test4(self):
        (part1, _) = packetDecoder("A0016C880162017C3686B18A3D4780".splitlines())
        self.assertEqual(part1, 31)

    def test5(self):
        (_, part2) = packetDecoder("C200B40A82".splitlines())
        self.assertEqual(part2, 3)

    def test6(self):
        (_, part2) = packetDecoder("04005AC33890".splitlines())
        self.assertEqual(part2, 54)

    def test7(self):
        (_, part2) = packetDecoder("880086C3E88112".splitlines())
        self.assertEqual(part2, 7)

    def test8(self):
        (_, part2) = packetDecoder("CE00C43D881120".splitlines())
        self.assertEqual(part2, 9)

    def test8(self):
        (_, part2) = packetDecoder("D8005AC2A8F0".splitlines())
        self.assertEqual(part2, 1)

    def test9(self):
        (_, part2) = packetDecoder("F600BC2D8F".splitlines())
        self.assertEqual(part2, 0)

    def test10(self):
        (_, part2) = packetDecoder("9C005AC2F8F0".splitlines())
        self.assertEqual(part2, 0)

    def test11(self):
        (_, part2) = packetDecoder("9C0141080250320F1802104A08".splitlines())
        self.assertEqual(part2, 1)


unittest.main()
