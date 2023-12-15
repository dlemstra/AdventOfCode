<?php

function getHASH(string $char, int $value): int
{
    $value += ord($char);
    $value *= 17;
    return $value % 256;
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$part1 = 0;
$parts = explode(',', $lines[0]);
foreach ($parts as $part) {
    $value = 0;
    foreach (str_split($part) as $char) {
        $value = getHASH($char, $value);
    }
    $part1 += $value;
}

echo "$part1\n";
