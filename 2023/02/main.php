<?php

$lines = file('input');

$part1 = 0;
$part2 = 0;
foreach ($lines as $line) {
    $info = explode(': ', $line);
    $reveals = explode('; ', $info[1]);
    $possible = true;
    $maxRed = $maxGreen = $maxBlue = 0;
    foreach ($reveals as $revealed) {
        $cubes = explode(', ', $revealed);
        $red = $green = $blue = 0;
        foreach ($cubes as $cube) {
            $cube = explode(' ', $cube);
            switch (trim($cube[1])) {
                case 'red':
                    $red = $cube[0];
                    break;
                case 'green':
                    $green = $cube[0];
                    break;
                case 'blue':
                    $blue = $cube[0];
                    break;
            }
        }
        $maxRed = max($maxRed, $red);
        $maxGreen = max($maxGreen, $green);
        $maxBlue = max($maxBlue, $blue);
        if ($red > 12 || $green > 13 || $blue > 14) {
            $possible = false;
        }
    }

    $part2 += $maxRed * $maxGreen * $maxBlue;
    if ($possible === true) {
        $id = explode(' ', $info[0])[1];
        $part1 += $id;
    }
}

echo $part1 . "\n";
echo $part2 . "\n";
