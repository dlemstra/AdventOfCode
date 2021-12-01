import sys

def sonarSweep(input):
    count = 0
    prev = sys.maxsize
    for line in input:
        number = int(line)
        if number > prev:
            count += 1
        prev = number

    return count
