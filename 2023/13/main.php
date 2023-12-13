<?php

function findRow(array $lines, int $startY, int $maxY, int $maxX, int $oldPos): int
{
    $pos = -1;
    for ($x = 1; $x < $maxX; $x++) {
        $leftX = $x - 1;
        $rightX = $x;
        $smudgeFound = false;
        if ($lines[$startY][$leftX] === $lines[$startY][$rightX] || $oldPos !== -1) {
            $pos = $x;
            if ($pos === $oldPos) {
                $pos = -1;
                continue;
            }
            $pos = $x;

            while ($leftX >= 0 && $rightX < $maxX && $pos !== -1) {
                for ($y = $startY; $y < $maxY; $y++) {
                    if ($lines[$y][$leftX] !== $lines[$y][$rightX]) {
                        if ($oldPos !== -1 && $smudgeFound === false) {
                            $smudgeFound = true;
                            continue;
                        }

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

    return $pos;
}

function findColumn(array $lines, int $startY, int $maxY, int $maxX, int $oldPos): int
{
    $pos = -1;
    for ($y = $startY + 1; $y < $maxY; $y++) {
        $topY = $y - 1;
        $bottomY = $y;
        $smudgeFound = false;
        if ($lines[$y][0] === $lines[$y][0] || $oldPos !== -1) {
            $pos = ($y - $startY) * 100;
            if ($pos === $oldPos) {
                $pos = -1;
                continue;
            }

            while ($topY >= $startY && $bottomY < $maxY && $pos !== -1) {
                for ($x = 0; $x < $maxX; $x++) {
                    if ($lines[$topY][$x] !== $lines[$bottomY][$x]) {
                        if ($oldPos !== -1 && $smudgeFound === false) {
                            $smudgeFound = true;
                            continue;
                        }

                        $pos = -1;
                        break;
                    }
                }
                $topY--;
                $bottomY++;
            }
        }

        if ($pos !== -1) {
            break;
        }
    }

    return $pos;
}

function findPos(array $lines, int $startY, int $maxY, int $maxX, int $oldPos = -1): int
{
    $row = findRow($lines, $startY, $maxY, $maxX, $oldPos);
    if ($row !== -1)
        return $row;

    return findColumn($lines, $startY, $maxY, $maxX, $oldPos);
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$index = 0;

$start = 0;
$part1 = 0;
$part2 = 0;
for ($i = 0; $i < count($lines); $i++) {
    $line = $lines[$i];
    if ($line !== '' && $i !== count($lines) - 1)
        continue;

    $maxX = strlen($lines[$start]);

    $pos = findPos($lines, $start, $i, $maxX);
    $part1 += $pos;
    $part2 += findPos($lines, $start, $i, $maxX, $pos);

    $start = $i + 1;
}

echo $part1 . "\n";
echo $part2 . "\n";
