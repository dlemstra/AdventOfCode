<?php

$lines = file('input', FILE_IGNORE_NEW_LINES);

function countWins($time, $record) {
    $speed = 2;
    $start = 0;
    for( $i = $speed; $i < $time; $i++, $speed++) {
        $remaining = $time - $i;
        if ($remaining * $speed > $record) {
            $start = $i;
            break;
        }
    }

    $speed = $time - 1;
    $end = 0;
    for( $i = $speed; ; $i--, $speed--) {
        $remaining = $time - $i;
        if ($remaining * $speed > $record) {
            $end = $i;
            break;
        }
    }

    return $end - $start + 1;
}


$times = preg_split('/\s+/', trim(explode('Time:', $lines[0])[1]));
$distances = preg_split('/\s+/', trim(explode('Distance:', $lines[1])[1]));

$part1 = 1;
for ($i = 0; $i < count($distances); $i++) {
    $time = $times[$i];
    $record = $distances[$i];

    $part1 *= countWins($time, $record);
}

echo $part1 . "\n";

$time = join("", $times);
$record = join("", $distances);
$part2 = countWins($time, $record);

echo $part2 . "\n";
