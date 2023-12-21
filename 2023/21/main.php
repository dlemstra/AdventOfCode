<?php
class Position
{
    public readonly int $x;
    public readonly int $y;

    public function __construct(int $x, int $y)
    {
        $this->x = $x;
        $this->y = $y;
    }

    public function key()
    {
        return $this->x . "x" . $this->y;
    }
}

function getPosition(array $grid, int $x, int $y, array &$visited, int $size): ?Position
{
    $pos = new Position($x, $y);

    if ($x < 0) $x = $size - abs($x % $size);
    if ($x >= $size) $x = $x % $size;
    if ($y < 0) $y = $size - abs($y % $size);
    if ($y >= $size) $y = $y % $size;

    if ($grid[$y][$x] === '#') {
        return null;
    }

    if (isset($visited[$pos->key()])) {
        return null;
    }

    $visited[$pos->key()] = true;

    return $pos;
}

function countPlots(array $grid, int $size, array &$startPositions, int $maxSteps): array
{
    $positions = $startPositions;
    for ($i = 0; $i < $maxSteps; $i++) {
        $newPositions = [];
        $visited = [];
        foreach ($positions as $pos) {
            $newPos = getPosition($grid, $pos->x - 1, $pos->y, $visited, $size);
            if ($newPos !== null)
                $newPositions[] = $newPos;

            $newPos = getPosition($grid, $pos->x + 1, $pos->y, $visited, $size);
            if ($newPos !== null)
                $newPositions[] = $newPos;

            $newPos = getPosition($grid, $pos->x, $pos->y - 1, $visited, $size);
            if ($newPos !== null)
                $newPositions[] = $newPos;

            $newPos = getPosition($grid, $pos->x, $pos->y + 1, $visited, $size);
            if ($newPos !== null)
                $newPositions[] = $newPos;
        }

        $positions = $newPositions;
    }

    return $positions;
}

$grid = file('input', FILE_IGNORE_NEW_LINES);

$size = strlen($grid[0]);
$center = floor($size / 2);
$positions = [new Position($center, $center)];

$steps = 26501365;
$start = $steps % $size;
if ($start === 0) $start = $size;

$i = 64;
$positions = countPlots($grid, $size, $positions, $i);
echo count($positions) . "\n";
while ($i++ % $start !== 0) {
    $positions = countPlots($grid, $size, $positions, 1);
}

$prev = 0;
$prevDelta = 0;
$diffIndex = 0;
$diffs = [0, 0];
for ($i = 1; $i < 10; $i++) {
    $positions = countPlots($grid, $size, $positions, $size);
    $count = count($positions);
    $delta = $count - $prev;
    $prev = $count;
    $newDelta = $delta - $prevDelta;
    $diff = $newDelta - $prevDelta;
    $prevDelta = $newDelta;
    if ($diffs[$diffIndex % 2] === $diff)
        break;
    $diffs[$diffIndex % 2]  = $diff;
    $diffIndex++;
}

$part2 = $count;
$stepSize = $prevDelta;
$stepSize += $diffs[0];
$stepSize += $stepSize + $diffs[1];
$stepSize = ($stepSize - $delta)  / 2;

$i = ($i +1) * $size;
while ($i < $steps) {
    $delta += $stepSize;
    $part2 += $delta;
    $i += $size;
}

echo $part2  . "\n";
