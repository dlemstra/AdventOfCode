<?php

class Grid
{
    public readonly int $maxX;
    public readonly int $maxY;
    private readonly array $grid;

    public function __construct(array $grid)
    {
        $this->grid = $grid;
        $this->maxX = strlen($grid[0]);
        $this->maxY = count($grid);
    }

    public function get(int $x, int $y): string
    {
        return $this->grid[$y][$x];
    }
}

class Position
{
    public readonly int $x;
    public readonly int $y;
    public readonly int $steps;
    private array $visited;

    public function __construct(int $x, int $y, int $steps = 0, array $visited = [])
    {
        $this->x = $x;
        $this->y = $y;
        $this->steps = $steps;
        $this->visited = $visited;
    }

    public function getNextSteps(Grid $grid): iterable
    {
        $newPositions = [[$this->x, $this->y - 1], [$this->x + 1, $this->y], [$this->x, $this->y + 1], [$this->x - 1, $this->y]];
        switch ($grid->get($this->x, $this->y)) {
            case '^':
                $position = $this->createPosition($grid, $newPositions[0][0], $newPositions[0][1]);
                if ($position !== null) yield $position;
                break;
            case '>':
                $position = $this->createPosition($grid, $newPositions[1][0], $newPositions[1][1]);
                if ($position !== null) yield $position;
                break;
            case 'v':
                $position = $this->createPosition($grid, $newPositions[2][0], $newPositions[2][1]);
                if ($position !== null) yield $position;
                break;
            case '<':
                $position = $this->createPosition($grid, $newPositions[3][0], $newPositions[3][1]);
                if ($position !== null) yield $position;
                break;
            default:
                foreach ($newPositions as $newPosition) {
                    $position = $this->createPosition($grid, $newPosition[0], $newPosition[1]);
                    if ($position !== null)
                        yield $position;
                }
                break;
        }
    }

    public function createPosition(Grid $grid, int $x, int $y): ?Position
    {
        if ($x < 0 || $x >= $grid->maxX || $y < 0 || $y >= $grid->maxY)
            return null;

        if ($grid->get($x, $y) == '#')
            return null;

        if (isset($this->visited[$x][$y]))
            return null;

        $this->visited[$x][$y] = true;

        return new Position($x, $y, $this->steps + 1, $this->visited);
    }
}

$grid = file('input', FILE_IGNORE_NEW_LINES);

$grid = new Grid($grid);

$y = 0;
for ($x = 0; $x < $grid->maxX; $x++) {
    if ($grid->get($x, 0) == '.')
        break;
}

$visted = [];
$positions = [new Position($x, $y)];

$part1 = 0;
while (count($positions) > 0) {
    $position = array_pop($positions);

    if (isset($visted[$position->x][$position->y]) && $visted[$position->x][$position->y] > $position->steps)
        continue;

    $visted[$position->x][$position->y] = $position->steps;

    foreach ($position->getNextSteps($grid) as $nextPosition) {
        if ($nextPosition->y === $grid->maxY - 1) {
            $part1 = max($part1, $nextPosition->steps);
        }

        $positions[] = $nextPosition;
    }
}

echo $part1 . "\n";
