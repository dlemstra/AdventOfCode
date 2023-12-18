<?php

function floodFill(array &$grid, $minX, $minY, $maxX, $maxY)
{
    $positions = [[$minX, $minY]];
    while (count($positions) > 0) {
        $position = array_pop($positions);
        $x = $position[0];
        $y = $position[1];
        if (!isset($grid[$y]))
            $grid[$y] = [];

        if (isset($grid[$y][$x]))
            continue;

        $grid[$y][$x] = 0;
        if ($x < $maxX) $positions[] = [$x + 1, $y];
        if ($x > $minX) $positions[] = [$x - 1, $y];
        if ($y < $maxY) $positions[] = [$x, $y + 1];
        if ($y > $minY) $positions[] = [$x, $y - 1];
    }
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$index = 0;

$grid = [];
$x = 0;
$y = 0;
$minX = $maxX = $minY = $maxY = 0;
foreach ($lines as $line) {
    $parts = explode(' ', $line);
    switch ($parts[0]) {
        case 'R':
            for ($i = 0; $i < $parts[1]; $i++) {
                $grid[$y][$x] = "#";
                $x++;
                $maxX = max($maxX, $x);
            }
            break;
        case 'L':
            for ($i = 0; $i < $parts[1]; $i++) {
                $grid[$y][$x] = "#";
                $x--;
                $minX = min($minX, $x);
            }
            break;
        case 'U':
            for ($i = 0; $i < $parts[1]; $i++) {
                $grid[$y][$x] = "#";
                $y--;
                $minY = min($minY, $y);
            }
            break;
        case 'D':
            for ($i = 0; $i < $parts[1]; $i++) {
                $grid[$y][$x] = "#";
                $y++;
                $maxY = max($maxY, $y);
            }
            break;
    }
}

$maxX++;
$maxY++;

floodFill($grid, $minX - 1, $minY - 1, $maxX + 1, $maxY + 1);

$part1 = 0;
for ($y = $minY; $y < $maxY; $y++) {
    for ($x = $minX; $x < $maxX; $x++) {
        if (!isset($grid[$y][$x]) || $grid[$y][$x] !== 0) {
            $part1++;
        }
    }
}

echo $part1 . "\n";
