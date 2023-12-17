<?php

enum Direction: int
{
    case North = 0;
    case East = 1;
    case South = 2;
    case West = 3;

    public function toInt(): int
    {
        return match ($this) {
            self::North => 0,
            self::East => 1,
            self::South => 2,
            self::West => 3,
        };
    }
}


class Move
{
    private readonly int $x;
    private readonly int $y;
    private readonly Direction $direction;
    public readonly int $heatloss;
    private readonly int $steps;

    public function __construct(int $x, int $y, Direction $direction, $heatloss = 0, $steps = 1)
    {
        $this->x = $x;
        $this->y = $y;
        $this->direction = $direction;
        $this->heatloss = $heatloss;
        $this->steps = $steps;
    }

    public function key()
    {
        return $this->x . "x" . $this->y . "x" . $this->direction->toInt() . "x" . $this->steps;
    }

    public function isCorner(int $maxX, int $maxY): bool
    {
        return $this->x === $maxX - 1 && $this->y === $maxY - 1;
    }

    public function nextMoves(array $grid, int $maxX, int $maxY): iterable
    {
        switch ($this->direction) {
            case Direction::North:
                if ($this->y > 0 && $this->steps < 3)
                    yield new Move($this->x, $this->y - 1, Direction::North, $this->heatloss + (int) $grid[$this->y - 1][$this->x], $this->steps + 1);
                if ($this->x > 0)
                    yield new Move($this->x - 1, $this->y, Direction::West, $this->heatloss + (int) $grid[$this->y][$this->x - 1]);
                if ($this->x < $maxX - 1)
                    yield new Move($this->x + 1, $this->y, Direction::East, $this->heatloss + (int) $grid[$this->y][$this->x + 1]);
                break;
            case Direction::East:
                if ($this->x < $maxX - 1 &&  $this->steps < 3)
                    yield new Move($this->x + 1, $this->y, Direction::East, $this->heatloss + (int) $grid[$this->y][$this->x + 1], $this->steps + 1);
                if ($this->y > 0)
                    yield new Move($this->x, $this->y - 1, Direction::North, $this->heatloss + (int) $grid[$this->y - 1][$this->x]);
                if ($this->y < $maxY - 1)
                    yield new Move($this->x, $this->y + 1, Direction::South, $this->heatloss + (int) $grid[$this->y + 1][$this->x]);
                break;
            case Direction::South:
                if ($this->y < $maxY - 1 && $this->steps < 3)
                    yield new Move($this->x, $this->y + 1, Direction::South, $this->heatloss + (int) $grid[$this->y + 1][$this->x], $this->steps + 1);
                if ($this->x > 0)
                    yield new Move($this->x - 1, $this->y, Direction::West, $this->heatloss + (int) $grid[$this->y][$this->x - 1]);
                if ($this->x < $maxX - 1)
                    yield new Move($this->x + 1, $this->y, Direction::East, $this->heatloss + (int) $grid[$this->y][$this->x + 1]);
                break;
            case Direction::West:
                if ($this->x > 0 && $this->steps < 3)
                    yield new Move($this->x - 1, $this->y, Direction::West, $this->heatloss + (int) $grid[$this->y][$this->x - 1], $this->steps + 1);
                if ($this->y > 0)
                    yield new Move($this->x, $this->y - 1, Direction::North, $this->heatloss + (int) $grid[$this->y - 1][$this->x]);
                if ($this->y < $maxY - 1)
                    yield new Move($this->x, $this->y + 1, Direction::South, $this->heatloss + (int) $grid[$this->y + 1][$this->x]);
                break;
        }
    }
}

function findLowestHeatloss(array &$moves): Move
{
    $lowest = null;
    $lowestIndex = -1;

    foreach ($moves as $index => $move) {
        if ($lowest === null || $move->heatloss < $lowest->heatloss) {
            $lowest = $move;
            $lowestIndex = $index;
        }
    }

    unset($moves[$lowestIndex]);

    return $lowest;
}

$grid = file('input', FILE_IGNORE_NEW_LINES);

$maxX = strlen($grid[0]);
$maxY = count($grid);

$moves = [new Move(1, 0, Direction::East, (int) $grid[0][1]), new Move(0, 1, Direction::South, (int) $grid[1][0])];
$visited = [];

while (count($moves) > 0) {
    $move = findLowestHeatloss($moves);

    if (isset($visited[$move->key()])) {
        continue;
    }

    if ($move->isCorner($maxX, $maxY)) {
        echo $move->heatloss . "\n";
        break;
    }

    $visited[$move->key()] = $move->heatloss;

    foreach ($move->nextMoves($grid, $maxX, $maxY) as $nextMove) {
        if (isset($visited[$nextMove->key()]) && $nextMove->heatloss >= $visited[$nextMove->key()])
            continue;

        $moves[] = $nextMove;
    }
}
