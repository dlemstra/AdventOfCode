<?php

$lines = file('input', FILE_IGNORE_NEW_LINES);

$part1 = 0;
$cards = [];
foreach (range(1, count($lines)) as $number) {
    $cards[$number] = 1;
}

foreach ($lines as $line) {
    $info = explode(' | ', $line);
    $winningInfo = explode(': ', $info[0]);
    $winning = array_map('intval', array_filter(explode(' ', $winningInfo[1])));
    $mine = array_map('intval', array_filter(explode(' ', $info[1])));
    $count = 0;
    foreach ($winning as $number) {
        if (in_array($number, $mine)) {
            $count++;
        }
    }

    $winningInfo = explode(' ', $winningInfo[0]);
    $number = (int)end($winningInfo);

    if ($count > 0) {
        $part1 += pow(2, $count - 1);

        for ($i = 1; $i < $count + 1; $i++) {
            if (array_key_exists($number + $i, $cards)) {
                $cards[$number + $i] += $cards[$number];
            }
        }
    }
}

echo $part1 . "\n";
echo array_sum($cards) . "\n";
