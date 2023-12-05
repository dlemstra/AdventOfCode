<?php

$lines = file('input', FILE_IGNORE_NEW_LINES);

$seeds = explode(' ', substr($lines[0], 7));

$part1 = 2147483647;
foreach ($seeds as $seed) {
    $found = false;
    for ($i = 3; $i < count($lines); $i++) {
        if ($lines[$i] === '') {
            $i += 1;
            $found = false;
            continue;
        }

        if ($found !== false) {
            continue;
        }

        $info = array_map('intval', explode(' ', $lines[$i]));
        if ($seed >= $info[1] && $seed <= $info[1] + $info[2]) {
            $seed += $info[0] - $info[1];
            $found = true;
        }
    }

    $part1 = min($part1, $seed);
}

echo $part1 . "\n";
