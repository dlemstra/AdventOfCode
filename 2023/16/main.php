<?php

enum Direction
{
    case North;
    case East;
    case South;
    case West;
}

class Move
{
    public int $x;
    public int $y;
    public Direction $direction;

    public function __construct($x, $y, $direction)
    {
        $this->x = $x;
        $this->y = $y;
        $this->direction = $direction;
    }

    function addToVisited(array &$visited): bool
    {
        $key = $this->x . 'x' . $this->y;
        if (!isset($visited[$key])) {
            $visited[$key] = [$this->direction];
            return true;
        }

        if (!in_array($this->direction, $visited[$key])) {
            $visited[$key][] = $this->direction;
            return true;
        }

        return false;
    }

    function nextMoves(array &$visited, array $grid, int $maxX, int $maxY): iterable
    {
        $x = $this->x;
        $y = $this->y;

        $newMoves = [];
        switch ($grid[$y][$x]) {
            case '|':
                if ($this->direction === Direction::North || $this->direction === Direction::South) {
                    $y = $this->direction === Direction::North ? $y - 1 : $y + 1;
                    $newMoves[] = new Move($x, $y, $this->direction);
                } else {
                    $newMoves[] = new Move($x, $y - 1, Direction::North);
                    $newMoves[] = new Move($x, $y + 1, Direction::South);
                }
                break;
            case '-':
                if ($this->direction === Direction::East || $this->direction === Direction::West) {
                    $x = $this->direction === Direction::East ? $x + 1 : $x - 1;
                    $newMoves[] = new Move($x, $y, $this->direction);
                } else {
                    $newMoves[] = new Move($x - 1, $y, Direction::West);
                    $newMoves[] = new Move($x + 1, $y, Direction::East);
                }
                break;
            case '/':
                if ($this->direction === Direction::North)
                    $newMoves[] = new Move($x + 1, $y, Direction::East);
                elseif ($this->direction === Direction::East)
                    $newMoves[] = new Move($x, $y - 1, Direction::North);
                elseif ($this->direction === Direction::South)
                    $newMoves[] = new Move($x - 1, $y, Direction::West);
                elseif ($this->direction === Direction::West)
                    $newMoves[] = new Move($x, $y + 1, Direction::South);
                break;
            case '\\':
                if ($this->direction === Direction::North)
                    $newMoves[] = new Move($x - 1, $y, Direction::West);
                elseif ($this->direction === Direction::East)
                    $newMoves[] = new Move($x, $y + 1, Direction::South);
                elseif ($this->direction === Direction::South)
                    $newMoves[] = new Move($x + 1, $y, Direction::East);
                elseif ($this->direction === Direction::West)
                    $newMoves[] = new Move($x, $y - 1, Direction::North);
                break;
            default:
                if ($this->direction === Direction::North)
                    $newMoves[] = new Move($x, $y - 1, Direction::North);
                elseif ($this->direction === Direction::East)
                    $newMoves[] = new Move($x + 1, $y, Direction::East);
                elseif ($this->direction === Direction::South)
                    $newMoves[] = new Move($x, $y + 1, Direction::South);
                elseif ($this->direction === Direction::West)
                    $newMoves[] = new Move($x - 1, $y, Direction::West);
                break;
        }

        foreach ($newMoves as $newMove) {
            if ($newMove->isValid($maxY, $maxX) && $newMove->addToVisited($visited))
                yield $newMove;
        }
    }

    private function isValid(int $maxY, int $maxX): bool
    {
        return $this->x >= 0 && $this->x < $maxX && $this->y >= 0 && $this->y < $maxY;
    }
}

function energizeTiles(array $grid, int $maxX, int $maxY, Move $move): int
{
    $visited = [];

    $moves[] = $move;
    $moves[0]->addToVisited($visited);

    while (count($moves) > 0) {
        $move = array_shift($moves);
        foreach ($move->nextMoves($visited, $grid, $maxX, $maxY) as $nextMove) {
            $moves[] = $nextMove;
        }
    }

    return count($visited);
}

$grid = file('input', FILE_IGNORE_NEW_LINES);

$maxX = strlen($grid[0]);
$maxY = count($grid);

$part1 = energizeTiles($grid, $maxX, $maxY, new Move(0, 0, Direction::East));
echo $part1 . "\n";

$part2 = 0;
for ($y = 0; $y < $maxY; $y++) {
    $part2 = max($part2, energizeTiles($grid, $maxX, $maxY, new Move(0, $y, Direction::East)));
    $part2 = max($part2, energizeTiles($grid, $maxX, $maxY, new Move($maxX - 1, $y, Direction::West)));
}
for ($x = 0; $x < $maxX; $x++) {
    $part2 = max($part2, energizeTiles($grid, $maxX, $maxY, new Move($x, 0, Direction::South)));
    $part2 = max($part2, energizeTiles($grid, $maxX, $maxY, new Move($x, $maxY - 1, Direction::North)));
}

echo $part2 . "\n";
