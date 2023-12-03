<?php

$lines = file('input', FILE_IGNORE_NEW_LINES);

function isSymbol($line, $i)
{
    if ($i < 0) return false;
    if ($i >= strlen($line)) return false;
    return $line[$i] !== '.' && !ctype_digit($line[$i]);
}

function checkLine($lines, $i, $start, $end)
{
    if ($i < 0 || $i >= count($lines)) return false;
    for ($j = $start - 1; $j < $end + 2; $j++) {
        if (isSymbol($lines[$i], $j)) {
            return true;
        }
    }
}

function checkNumber($lines, $i, $start, $end)
{
    $number = substr($lines[$i], $start, $end - $start + 1);
    if (
        isSymbol($lines[$i], $start - 1) || isSymbol($lines[$i], $end + 1) ||
        checkLine($lines, $i - 1, $start, $end) || checkLine($lines, $i + 1, $start, $end)
    ) {
        return $number;
    }

    return 0;
}

$total = 0;
for ($i = 0; $i < count($lines); $i++) {
    $line = $lines[$i];

    $start = $end = -1;
    for ($j = 0; $j < strlen($line); ++$j) {
        if (ctype_digit($line[$j])) {
            if ($start === -1) {
                $start = $j;
            } else {
                $end = $j;
                if ($end === strlen($line) - 1) {
                    $total += checkNumber($lines, $i, $start, $end);
                    $start = $end = -1;
                }
            }
        } else if ($start !== -1) {
            if ($end === -1) $end = $start;
            $total += checkNumber($lines, $i, $start, $end);
            $start = $end = -1;
        }
    }
}

echo $total . "\n";
