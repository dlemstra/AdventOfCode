<?php

$lines = file('input', FILE_IGNORE_NEW_LINES);

$total = 0;
foreach ($lines as $line) {
    $info = explode(' | ', $line);
    $winning = array_map('intval', array_filter(explode(' ', explode(': ', $info[0])[1])));
    $mine = array_map('intval', array_filter(explode(' ', $info[1])));
    $point = 0;
    foreach ($winning as $number) {
        if (in_array($number, $mine)) {
            $point = $point === 0 ? 1 : $point * 2;
        }
    }
    $total += $point;
}

echo $total . "\n";
