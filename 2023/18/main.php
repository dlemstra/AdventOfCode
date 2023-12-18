<?php

function polygonArea($vertices)
{
    $area = 0;
    for ($i = 0; $i < count($vertices) - 1; $i++) {
        $area = $area + ($vertices[$i + 1][0] + $vertices[$i][0]) * ($vertices[$i + 1][1] - $vertices[$i][1]);
    }

    return abs($area / 2);
}

function getAreaSize(array $lines, bool $part1)
{
    $points = [];

    $x = 0;
    $y = 0;
    $border = 0;
    foreach ($lines as $line) {
        $parts = explode(' ', $line);
        if ($part1) {
            $direction = $parts[0];
            $length = (int)$parts[1];
        } else {
            $direction = $parts[2][7];
            $length = hexdec(substr($parts[2], 2, 5));
        }
        $border += $length;
        switch ($direction) {
            case 'R':
            case '0':
                $points[] = [$x, $y];
                $x += $length;
                break;
            case 'D':
            case '1':
                $points[] = [$x, $y];
                $y += $length;
                break;
            case 'L':
            case '2':
                $points[] = [$x, $y];
                $x -= $length;
                break;
            case 'U':
            case '3':
                $points[] = [$x, $y];
                $y -= $length;
                break;
        }
    }

    $area = polygonArea($points);
    $area += ($border / 2) + 1;
    return $area;
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

echo getAreaSize($lines, true) . "\n";
echo getAreaSize($lines, false) . "\n";
