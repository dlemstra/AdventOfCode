<?php

$lines = file('input', FILE_IGNORE_NEW_LINES);

$start = 0;
$total = 0;
for ($i = 0; $i < count($lines); $i++) {
    $line = $lines[$i];
    if ($line !== '' && $i !== count($lines) - 1) {
        continue;
    }

    $maxX = strlen($lines[$start]);

    $pos = -1;
    for ($x = 1; $x < $maxX; $x++) {
        $leftX = $x - 1;
        $rightX = $x;
        if ($lines[$start][$leftX] === $lines[$start][$rightX]) {
            $pos = $x;
            while ($leftX >= 0 && $rightX < $maxX && $pos !== -1) {
                for ($y = $start; $y < $i; $y++) {
                    if ($lines[$y][$leftX] !== $lines[$y][$rightX]) {
                        $pos = -1;
                        break;
                    }
                }
                $leftX--;
                $rightX++;
            }
        }

        if ($pos !== -1) {
            break;
        }
    }

    if ($pos === -1) {
        for ($y = $start + 1; $y < $i; $y++) {
            $topY = $y - 1;
            $bottomY = $y;
            if ($lines[$topY][0] === $lines[$bottomY][0]) {
                $pos = $y - $start;
                while ($topY >= $start && $bottomY < $i && $pos !== -1) {
                    for ($x = 0; $x < $maxX; $x++) {
                        if ($lines[$topY][$x] !== $lines[$bottomY][$x]) {
                            $pos = -1;
                            break;
                        }
                    }
                    $topY--;
                    $bottomY++;
                }
            }

            if ($pos !== -1) {
                $pos *= 100;
                break;
            }
        }
    }

    $total += $pos;

    $start = $i + 1;
}

echo $total . "\n";
