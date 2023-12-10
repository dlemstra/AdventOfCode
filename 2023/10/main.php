<?php

function getStartNext(array $grid, int $x, int $y): array
{
    if ($grid[$y][$x + 1] === "J" || $grid[$y][$x + 1] === "-" || $grid[$y][$x + 1] === "7") {
        return [$x + 1, $y];
    }
    if ($grid[$y][$x - 1] === "L" || $grid[$y][$x - 1] === "-" || $grid[$y][$x - 1] === "F") {
        return [$x - 1, $y];
    }
    if ($grid[$y + 1][$x] === "L" || $grid[$y + 1][$x] === "|" || $grid[$y + 1][$x] === "J") {
        return [$x, $y + 1];
    }
    if ($grid[$y - 1][$x] === "7" || $grid[$y - 1][$x] === "|" || $grid[$y - 1][$x] === "F") {
        return [$x, $y - 1];
    }
}

function getNextPosition(array $grid, int $prevX, int $prevY, int $x, int $y): array
{
    switch ($grid[$y][$x]) {
        case '|':
            return [$x, $y - 1 == $prevY ? $y + 1 : $y - 1];
        case '-':
            return [$x - 1 == $prevX ? $x + 1 : $x - 1, $y];
        case 'L':
            return $x + 1 == $prevX ? [$x, $y - 1] : [$x + 1, $y];
        case 'J':
            return $x - 1 == $prevX ? [$x, $y - 1] : [$x - 1, $y];
        case '7':
            return $x - 1 == $prevX ? [$x, $y + 1] : [$x - 1, $y];
        case 'F':
            return $x + 1 == $prevX ? [$x, $y + 1] : [$x + 1, $y];
    }

    return [];
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$startX = 0;
$startY = 0;
$grid[] = array_fill(0, strlen($lines[0]) + 2, ".");
foreach ($lines as $line) {
    $items = str_split($line);
    $index = array_search("S", $items);
    if ($index !== false) {
        $startX = $index + 1;
        $startY = count($grid);
    }
    $array = array_merge(["."], $items);
    $array[] = ".";
    $grid[] = $array;
}
$grid[] = array_fill(0, strlen($lines[0]) + 2, ".");

$count = 0;
$prevX = $startX;
$prevY = $startY;
$next = getStartNext($grid, $startX, $startY);
while ($grid[$next[1]][$next[0]] !== "S") {
    $prev = $next;
    $next = getNextPosition($grid, $prevX, $prevY, $next[0], $next[1]);
    if (count($next) === 0) {
        break;
    }
    $prevX = $prev[0];
    $prevY = $prev[1];
    $count++;
}

echo ($count + 1) / 2 . "\n";
