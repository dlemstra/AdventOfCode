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

class Grid
{
    public readonly int $maxX;
    public readonly int $maxY;
    public readonly int $maxSteps;
    public readonly int $minStepsBeforeMove;
    private readonly array $grid;

    public function __construct(array $grid, int $maxSteps, int $minStepsBeforeMove)
    {
        $this->grid = $grid;
        $this->maxX = strlen($grid[0]);
        $this->maxY = count($grid);
        $this->maxSteps = $maxSteps;
        $this->minStepsBeforeMove = $minStepsBeforeMove;
    }

    public function get(int $x, int $y): int
    {
        return (int) $this->grid[$y][$x];
    }
}

class MoveQueueItem
{
    public readonly Move $move;
    public ?MoveQueueItem $next = null;

    public function __construct(Move $move)
    {
        $this->move = $move;
    }
}

class MoveQueue
{
    private ?MoveQueueItem $first = null;

    public function add(Move $move)
    {
        if ($this->first === null) {
            $this->first = new MoveQueueItem($move);
        } else {
            $item = $this->first;
            $newItem = new MoveQueueItem($move);

            if ($move->isBetter($item->move)) {
                $newItem->next = $item;
                $this->first = $newItem;
                return;
            }

            while ($item->next !== null) {
                if ($move->isBetter($item->next->move)) {
                    break;
                }
                $item = $item->next;
            }

            $newItem->next = $item->next;
            $item->next = $newItem;
        }
    }

    public function removeFirst(): Move
    {
        $move = $this->first->move;
        $this->first = $this->first->next;
        return $move;
    }
}

class Move
{
    private readonly int $x;
    private readonly int $y;
    private readonly Direction $direction;
    public readonly int $heatloss;
    public readonly int $steps;
    public readonly string $key;

    public function __construct(int $x, int $y, Direction $direction, $heatloss, $steps)
    {
        $this->x = $x;
        $this->y = $y;
        $this->direction = $direction;
        $this->heatloss = $heatloss;
        $this->steps = $steps;
        $this->key = $x . "x" . $y . "x" . $direction->toInt(). "x" . $steps;
    }

    public function isEnd(Grid $grid): bool
    {
        return $this->x === $grid->maxX - 1 && $this->y === $grid->maxY - 1;
    }

    public function nextMoves(Grid $grid): iterable
    {
        switch ($this->direction) {
            case Direction::North:
                yield $this->createMove($this->x, $this->y - 1, Direction::North, $this->steps + 1, $grid);
                if ($this->steps >= $grid->minStepsBeforeMove) {
                    yield $this->createMove($this->x - 1, $this->y, Direction::West, 1, $grid);
                    yield $this->createMove($this->x + 1, $this->y, Direction::East, 1, $grid);
                }
                break;
            case Direction::East:
                yield $this->createMove($this->x + 1, $this->y, Direction::East, $this->steps + 1, $grid);
                if ($this->steps >= $grid->minStepsBeforeMove) {
                    yield $this->createMove($this->x, $this->y - 1, Direction::North, 1, $grid);
                    yield $this->createMove($this->x, $this->y + 1, Direction::South, 1, $grid);
                }
                break;
            case Direction::South:
                yield $this->createMove($this->x, $this->y + 1, Direction::South, $this->steps + 1, $grid);
                if ($this->steps >= $grid->minStepsBeforeMove) {
                    yield $this->createMove($this->x - 1, $this->y, Direction::West, 1, $grid);
                    yield $this->createMove($this->x + 1, $this->y, Direction::East, 1, $grid);
                }
                break;
            case Direction::West:
                yield $this->createMove($this->x - 1, $this->y, Direction::West, $this->steps + 1, $grid);
                if ($this->steps >= $grid->minStepsBeforeMove) {
                    yield $this->createMove($this->x, $this->y - 1, Direction::North, 1, $grid);
                    yield $this->createMove($this->x, $this->y + 1, Direction::South, 1, $grid);
                }
                break;
        }
    }

    public function isBetter(Move $other): bool
    {
        if ($this->heatloss < $other->heatloss)
            return true;

        if ($this->heatloss > $other->heatloss)
            return false;

        return $this->steps < $other->steps;
    }

    private function createMove(int $x, int $y, Direction $direction, int $steps, Grid $grid): ?Move
    {
        if ($x < 0 || $y < 0 || $x >= $grid->maxX || $y >= $grid->maxY || $steps > $grid->maxSteps)
            return null;

        if ($steps < $grid->minStepsBeforeMove) {
            $minRequired = $grid->minStepsBeforeMove - $steps;
            switch ($direction) {
                case Direction::North:
                    if ($y - $minRequired >= $grid->maxY) return null;
                    break;
                case Direction::East:
                    if ($x + $minRequired >= $grid->maxX) return null;
                    break;
                case Direction::South:
                    if ($y + $minRequired < 0) return null;
                    break;
                case Direction::West:
                    if ($x - $minRequired < 0) return null;
                    break;
            }
        }

        $heatloss = $this->heatloss + $grid->get($x, $y);

        return new Move($x, $y, $direction, $heatloss, $steps);
    }
}

function findBestRoute(Grid $grid)
{
    $moves = new MoveQueue();
    $moves->add(new Move(1, 0, Direction::East, $grid->get(1, 0), 1));
    $moves->add(new Move(0, 1, Direction::South, $grid->get(0, 1), 1));
    $visited = [];

    echo "\n";

    $value = 0;
    while (true) {
        $move = $moves->removeFirst();

        if (isset($visited[$move->key]))
            continue;

        if ($move->isEnd($grid))
            break;

        $visited[$move->key] = $move->heatloss;

        foreach ($move->nextMoves($grid) as $nextMove) {
            if ($nextMove === null || (isset($visited[$nextMove->key]) && $nextMove->heatloss >= $visited[$nextMove->key]))
                continue;

            $moves->add($nextMove);
        }

        if ($value !== $move->heatloss) {
            $value = $move->heatloss;
            echo "\033[1A" .  $move->heatloss . "\n";
        }
    }
}

$grid = file('input', FILE_IGNORE_NEW_LINES);

findBestRoute(new Grid($grid, 3, 1));
findBestRoute(new Grid($grid, 10, 4));
