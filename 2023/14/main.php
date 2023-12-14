<?php

$lines = file('input', FILE_IGNORE_NEW_LINES);

function moveNorth(array &$lines, int $maxX, int $maxY)
{
    for ($x = 0; $x < $maxX; $x++) {
        for ($y = 0; $y < $maxY; $y++) {
            if ($y > 0 && $lines[$y][$x] === 'O' && $lines[$y - 1][$x] === '.') {
                $lines[$y - 1][$x] = 'O';
                $lines[$y][$x] = '.';
                $y -= 2;
            }
        }
    }
}

function doCycle(array &$lines, int $maxX, int $maxY)
{
    moveNorth($lines, $maxX, $maxY);

    for ($y = 0; $y < $maxY; $y++) {
        for ($x = 0; $x < $maxX; $x++) {
            if ($x > 0 && $lines[$y][$x] === 'O' && $lines[$y][$x - 1] === '.') {
                $lines[$y][$x - 1] = 'O';
                $lines[$y][$x] = '.';
                $x -= 2;
            }
        }
    }

    for ($x = 0; $x < $maxX; $x++) {
        for ($y = $maxY - 1; $y > 0; $y--) {
            if ($y < $maxY && $lines[$y][$x] === '.' && $lines[$y - 1][$x] === 'O') {
                $lines[$y - 1][$x] = '.';
                $lines[$y][$x] = 'O';
                $y += 2;
            }
        }
    }

    for ($y = 0; $y < $maxY; $y++) {
        for ($x = $maxX - 1; $x > 0; $x--) {
            if ($x < $maxX && $lines[$y][$x] === '.' && $lines[$y][$x - 1] === 'O') {
                $lines[$y][$x - 1] = '.';
                $lines[$y][$x] = 'O';
                $x += 2;
            }
        }
    }
}

function countLoad(array $lines): int
{
    $load = 0;
    $weight = 1;
    for ($y = count($lines) - 1; $y >= 0; $y--) {
        for ($x = 0; $x < strlen($lines[0]); $x++) {
            if ($lines[$y][$x] === 'O') {
                $load += $weight;
            }
        }
        $weight++;
    }

    return $load;
}

function predictLoad(array $loads): mixed
{
    $last = end($loads);
    for ($i = count($loads) - 2; $i >= 0; $i--) {
        if ($loads[$i] == $last) {
            break;
        }
    }

    if ($i < 0) {
        return false;
    }

    $i++;
    $sequence = array_slice($loads, $i++);
    $index = (1000000000 - $i) % count($sequence);

    return $sequence[$index];
}

$maxX = strlen($lines[0]);
$maxY = count($lines);

$part1 = $lines;
moveNorth($part1, $maxX, $maxY);

echo countLoad($part1) . "\n";

$part2 = 0;

$loads = [];
$prev = 0;
for ($i = 0; $i < 1000; $i++) {

    doCycle($lines, $maxX, $maxY);

    $load = countLoad($lines);
    $loads[] = $load;

    $part2 = predictLoad($loads);
    if ($part2 !== false && $part2 === $prev) {
        break;
    }
    $prev = $part2;
}

echo $part2 . "\n";
