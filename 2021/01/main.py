from aoc import *

with open("input", "r") as input:
    data = input.readlines()

    (part1, part2) = sonarSweep(data)
    print(f"Part1: {part1}")
    print(f"Part2: {part2}")
