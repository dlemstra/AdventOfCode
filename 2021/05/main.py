from aoc import *

with open("input", "r") as input:
    data = input.read().splitlines()

    (part1, part2) = hydrothermalVenture(data)
    print(f"Part1: {part1}")
    if part2 != None:
        print(f"Part2: {part2}")
