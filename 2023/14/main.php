<?php

$lines = file('input', FILE_IGNORE_NEW_LINES);

for ($x = 0; $x < strlen($lines[0]); $x++) {
    for ($y = 0; $y < count($lines); $y++) {
        if ($y > 0 && $lines[$y][$x] === 'O' && $lines[$y - 1][$x] === '.') {
            $lines[$y - 1][$x] = 'O';
            $lines[$y][$x] = '.';
            $y -= 2;
        }
    }
}

$part1 = 0;
$weight = 1;
for ($y = count($lines) - 1; $y >= 0; $y--) {
    for ($x = 0; $x < strlen($lines[0]); $x++) {
        if ($lines[$y][$x] === 'O') {
            $part1 += $weight;
        }
    }
    $weight++;
}

echo $part1 . "\n";
