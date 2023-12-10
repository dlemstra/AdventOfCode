<?php

function getConnected(array $grid, int $x, int $y): array
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

    throw new Exception("Invalid position");
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

    throw new Exception("Invalid position");
}

function expandGrid(array $grid): array
{
    $newGrid = [array_fill(0, (count($grid[0]) * 2) - 3, ".")];
    for ($y = 1; $y < count($grid) - 1; $y++) {
        $newRow = ["."];
        for ($x = 1; $x < count($grid[$y]) - 1; $x++) {
            $newRow[] = $grid[$y][$x];
            $nextChar = ".";
            if ($grid[$y][$x] != ".") {
                if (($grid[$y][$x] === "L" || $grid[$y][$x] === "-" || $grid[$y][$x] === "F" || $grid[$y][$x] === "S") &&
                    ($grid[$y][$x + 1] === "J" || $grid[$y][$x + 1] === "-" || $grid[$y][$x + 1] === "7" || $grid[$y][$x + 1] === "S")
                ) {
                    $nextChar = "-";
                }
            }
            $newRow[] = $nextChar;
        }
        $newGrid[] = $newRow;

        $newRow = ["."];
        for ($x = 1; $x < count($grid[$y]) - 1; $x++) {
            $nextChar = ".";
            if (
                ($grid[$y][$x] === "7" || $grid[$y][$x] === "|" || $grid[$y][$x] === "F" || $grid[$y][$x] === "S") &&
                ($grid[$y + 1][$x] === "L" || $grid[$y + 1][$x] === "|" || $grid[$y + 1][$x] === "J" || $grid[$y + 1][$x] === "S")
            ) {
                $nextChar = "|";
            }
            $newRow[] = $nextChar;
            $newRow[] = ".";
        }
        $newGrid[] = $newRow;
    }

    return $newGrid;
}

function findPath(array &$grid, int $startX, int $startY, string $replacement = ""): int
{
    $length = 0;
    $prevX = $startX;
    $prevY = $startY;
    $next = getConnected($grid, $startX, $startY);
    while ($grid[$next[1]][$next[0]] !== "S") {
        $prev = $next;
        $next = getNextPosition($grid, $prevX, $prevY, $next[0], $next[1]);
        $prevX = $prev[0];
        $prevY = $prev[1];
        if ($replacement !== "") {
            $grid[$prevY][$prevX] = $replacement;
        }
        $length++;
    }

    return $length;
}

function floodFill(array &$grid)
{
    $maxX = count($grid[0]) - 1;
    $maxY = count($grid) - 1;
    $positions = [[0, 0]];
    while (count($positions) > 0) {
        $position = array_pop($positions);
        $x = $position[0];
        $y = $position[1];
        if ($grid[$y][$x] !== "S" && $grid[$y][$x] !== "O") {
            $grid[$y][$x] = "O";
            if ($x < $maxX) $positions[] = [$x + 1, $y];
            if ($x > 0) $positions[] = [$x - 1, $y];
            if ($y < $maxY) $positions[] = [$x, $y + 1];
            if ($y > 0) $positions[] = [$x, $y - 1];
        }
    }
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

$part1 = findPath($grid, $startX, $startY);
echo ($part1 + 1) / 2 . "\n";

$grid = expandGrid($grid);
findPath($grid, ($startX * 2) - 1, ($startY * 2) - 1, "S");

floodFill($grid);

$part2 = 0;
for ($y = 1; $y < count($grid); $y += 2) {
    for ($x = 1; $x < count($grid[$y]); $x += 2) {
        if ($grid[$y][$x] !== "S" && $grid[$y][$x] !== "O") {
            $part2++;
        }
    }
}

echo $part2 . "\n";
