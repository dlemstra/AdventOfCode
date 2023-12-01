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
