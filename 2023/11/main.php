<?php

function distance($x1, $y1, $x2, $y2) {
    return abs($x1 - $x2) + abs($y1 - $y2);
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$galaxies = [];
for ($y = 0; $y < count($lines); $y++) {
    for ($x = 0; $x < strlen($lines[$y]); $x++) {
        if ($lines[$y][$x] === '#') {
            $galaxies[] = [$x, $y];
        }
    }
}

$emptyX = [];
for ($x = strlen($lines[0]) - 2; $x >= 0; $x--) {
    $found = false;
    foreach ($galaxies as $galaxy) {
        if ($galaxy[0] === $x) {
            $found = true;
            break;
        }
    }

    if (!$found) {
        $emptyX[] = $x;
    }
}

foreach ($emptyX as $x) {
    for($i=0; $i < count($galaxies); $i++) {
        if ($galaxies[$i][0] > $x) {
            $galaxies[$i][0]++;
        }
    }
}

$emptyY = [];
for ($y = count($lines) - 2; $y >= 0; $y--) {
    $found = false;
    foreach ($galaxies as $galaxy) {
        if ($galaxy[1] === $y) {
            $found = true;
            break;
        }
    }

    if (!$found) {
        $emptyY[] = $y;
    }
}

foreach ($emptyY as $y) {
    for($i=0; $i < count($galaxies); $i++) {
        if ($galaxies[$i][1] > $y) {
            $galaxies[$i][1]++;
        }
    }
}

$total = 0;
for ($i = 0; $i < count($galaxies); $i++) {
    for ($j = $i; $j < count($galaxies); $j++) {
        $total += distance($galaxies[$i][0], $galaxies[$i][1], $galaxies[$j][0], $galaxies[$j][1]);
    }
}

echo $total . "\n";
