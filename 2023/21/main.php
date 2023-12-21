<?php
class Position
{
    public $x;
    public $y;
    public $steps;

    public function __construct(int $x, int $y, $steps = 0)
    {
        $this->x = $x;
        $this->y = $y;
        $this->steps = $steps;
    }

    public function key()
    {
        return $this->x . "x" . $this->y . "x" . $this->steps;
    }
}

$grid = file('input', FILE_IGNORE_NEW_LINES);

$maxX = strlen($grid[0]);
$maxY = count($grid);

$positions = [];
for ($y = 0; $y < $maxY && count($positions) == 0; $y++) {
    for ($x = 0; $x < $maxX; $x++) {
        if ($grid[$y][$x] === 'S') {
            $positions[] = new Position($x, $y);
            break;
        }
    }
}

$part1 = 0;
$visited = [];
$maxSteps = 64;
while (count($positions) > 0) {
    $pos = array_shift($positions);

    if (isset($visited[$pos->key()])) {
        continue;
    }

    $visited[$pos->key()] = true;

    if ($pos->steps == $maxSteps) {
        $part1++;
        continue;
    }

    if ($pos->x > 0 && $grid[$pos->y][$pos->x - 1] !== '#') {
        $newPos =  new Position($pos->x - 1, $pos->y, $pos->steps + 1);
        if (!isset($visited[$newPos->key()])) {
            $positions[] = $newPos;
        }
    }
    if ($pos->x < $maxX - 1 && $grid[$pos->y][$pos->x + 1] !== '#') {
        $newPos = new Position($pos->x + 1, $pos->y, $pos->steps + 1);
        if (!isset($visited[$newPos->key()])) {
            $positions[] = $newPos;
        }
    }
    if ($pos->y > 0 && $grid[$pos->y - 1][$pos->x] !== '#') {
        $newPos = new Position($pos->x, $pos->y - 1, $pos->steps + 1);
        if (!isset($visited[$newPos->key()])) {
            $positions[] = $newPos;
        }
    }
    if ($pos->y < $maxY - 1 && $grid[$pos->y + 1][$pos->x] !== '#') {
        $newPos = new Position($pos->x, $pos->y + 1, $pos->steps + 1);
        if (!isset($visited[$newPos->key()])) {
            $positions[] = $newPos;
        }
    }
}

echo $part1 . "\n";
