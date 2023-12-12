<?php

$lines = file('input', FILE_IGNORE_NEW_LINES);

function findMatches($line, $counts)
{
    $matches = 0;
    $questionCount = substr_count($line, '?');
    $combinations = pow(2, $questionCount);

    for ($i = 0; $i < $combinations; $i++) {
        $binary = str_pad(decbin($i), $questionCount, '0', STR_PAD_LEFT);

        $permutation = $line;
        for ($j = 0; $j < $questionCount; $j++) {
            $permutation = preg_replace('/\?/', $binary[$j] == '0' ? '.' : '#', $permutation, 1);
        }

        $count = 0;
        $permutationCount = [];
        for ($k = 0; $k < strlen($permutation); $k++) {
            if ($permutation[$k] == '.') {
                if ($count > 0) {
                    $permutationCount[] = $count;
                    $count = 0;
                }
            } else {
                $count++;
            }
        }

        if ($count > 0)
            $permutationCount[] = $count;

        if ($permutationCount == $counts)
            $matches++;
    }

    return $matches;
}

$part1 = 0;
foreach ($lines as $line) {
    $parts = explode(' ', $line);
    $counts = explode(',', $parts[1]);

    $part1 += findMatches($parts[0], $counts);
    echo $part1 . "\n";
}

echo $part1 . "\n";
