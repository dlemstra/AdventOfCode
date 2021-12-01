import sys

def increment_count(numbers):
    count = 0
    prev = sys.maxsize
    for number in numbers:
        if number > prev:
            count += 1
        prev = number
    return count

def sonarSweep(input):
    numbers = list(map(int, input))

    part1 = increment_count(numbers)

    new_numbers = []
    for i, number in enumerate(numbers[:-2]):
        total = 0
        for number in numbers[i:i+3]:
            total += number
        new_numbers.append(total)

    part2 = increment_count(new_numbers)

    return (part1, part2)
