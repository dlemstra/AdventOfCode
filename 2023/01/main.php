<?php

$input = file("input");

$total = 0;
foreach ($input as $line) {
    $firstNumber = -1;
    $secondNumber = -1;

    for ($i = 0; $i < strlen($line); ++$i) {
        if (is_numeric($line[$i])) {
            if ($firstNumber === -1) {
                $firstNumber = $line[$i];
            } else {
                $secondNumber = $line[$i];
            }
        }
    }

    $total += $firstNumber * 10;
    if ($secondNumber !== -1) {
        $total += $secondNumber;
    } else {
        $total += $firstNumber;
    }
}

echo $total . "\n";

function getAllIndexes($haystack, $needle) {
    $pos = 0;
    $allpos = [];

    while (($pos = strpos($haystack, $needle, $pos)) !== false) {
        $allpos[] = $pos++;
    }

    return $allpos;
}

$total = 0;
$numbers = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];
foreach ($input as $line) {
    $indexes = [];

    for ($i = 0; $i < strlen($line); $i++) {
        if (is_numeric($line[$i])) {
            $indexes[$i] = $line[$i];
        }
    }

    for ($i = 0; $i < count($numbers); ++$i) {
       foreach (getAllIndexes($line, $numbers[$i]) as $index) {
           $indexes[$index] = $i + 1;
       }
    }

    ksort($indexes);

    $keys = array_keys($indexes);
    $total += $indexes[$keys[0]] * 10;
    $total += $indexes[$keys[count($keys) - 1]];
}

echo $total . "\n";
