<?php

function getHASH(string $char, int $value): int
{
    $value += ord($char);
    $value *= 17;
    return $value % 256;
}

function calcHash(string $value): int
{
    $hash = 0;
    foreach (str_split($value) as $char) {
        $hash = getHASH($char, $hash);
    }
    return $hash;
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$item = 0;
$part1 = 0;
$boxes = [];
$parts = explode(',', $lines[0]);
foreach ($parts as $part) {
    $part1 += calcHASH($part);

    $set = true;
    $info = explode('=', $part);
    if (count($info) === 1) {
        $set = false;
        $info = explode('-', $part);
    }

    $label = $info[0];
    $box = calcHASH($label);
    if (!isset($boxes[$box]))
        $boxes[$box] = [];

    $matches = array_filter($boxes[$box], function ($value) use ($label) {
        return strpos($value, $label) === 0;
    });

    $index = array_search(reset($matches), $boxes[$box]);

    if ($set === true) {
        $newValue = str_replace("=", " ", $part);

        if ($index === false) {
            $boxes[$box][] = $newValue;
        } else {
            $boxes[$box][$index] = $newValue;
        }
    } else if ($index !== false) {
        unset($boxes[$box][$index]);
        $boxes[$box] = array_values($boxes[$box]);
    }
}

$part2 = 0;
foreach (array_keys($boxes) as $box) {
    for ($i = 0; $i < count($boxes[$box]); $i++) {
        $focalLength = (int) explode(" ", $boxes[$box][$i])[1];
        $part2 += ($box + 1) * ($i + 1) * $focalLength;
    }
}

echo "$part1\n";
echo "$part2\n";
