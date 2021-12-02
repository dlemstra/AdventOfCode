from aoc import *

with open("input", "r") as input:
    data = input.readlines()

    part1 = dive(data)
    print(f"Part1: {part1}")
