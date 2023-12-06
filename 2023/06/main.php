<?php

$lines = file('input', FILE_IGNORE_NEW_LINES);

$times = preg_split('/\s+/', trim(explode('Time:', $lines[0])[1]));
$distances = preg_split('/\s+/', trim(explode('Distance:', $lines[1])[1]));

$part1 = 1;
for ($i = 0; $i < count($distances); $i++) {
    $time = $times[$i];
    $record = $distances[$i];

    $count = 0;
    $speed = 2;
    for( $j = 2; $j < $time; $j++) {
        $remaining = $time - $j;
        if ($remaining * $speed > $record) {
            $count++;
        }
        $speed++;
    }
    $part1 *= $count;
}

echo $part1 . "\n";
