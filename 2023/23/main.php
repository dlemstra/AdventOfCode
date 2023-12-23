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

    public function loadIntersections(): array
    {
        $intersections = [];
        for ($y = 0; $y < $this->maxY; $y++) {
            for ($x = 0; $x < $this->maxX; $x++) {
                $position =  new Position($x, $y);
                $neighbours = $position->getNeighbours($this, true);
                if ($this->get($x, $y) === '.' && ($y === 0 || $y === $this->maxY - 1 || count($neighbours) > 2))
                    $intersections[$x][$y] = new Intersection($position);
            }
        }

        return $intersections;
    }
}

class Position
{
    public readonly int $x;
    public readonly int $y;
    public readonly int $steps;

    public function __construct(int $x, int $y, int $steps = 0)
    {
        $this->x = $x;
        $this->y = $y;
        $this->steps = $steps;
    }

    function getNeighbours(Grid $grid, bool $climbSteepSlopes): array
    {
        $newPositions = [];
        foreach ([[$this->x, $this->y - 1], [$this->x + 1, $this->y], [$this->x, $this->y + 1], [$this->x - 1, $this->y]] as $index => $pos) {
            if (!$climbSteepSlopes) {
                $skip = false;
                switch ($grid->get($this->x, $this->y)) {
                    case '^':
                        if ($index !== 0) $skip = true;
                        break;
                    case '>':
                        if ($index !== 1) $skip = true;
                        break;
                    case 'v':
                        if ($index !== 2) $skip = true;
                        break;
                    case '<':
                        if ($index !== 3) $skip = true;
                        break;
                }

                if ($skip)
                    continue;
            }

            $position = new Position($pos[0], $pos[1], $this->steps + 1);
            if ($position->x < 0 || $position->x >= $grid->maxX || $position->y < 0 || $position->y >= $grid->maxY)
                continue;

            if ($grid->get($position->x, $position->y) === '#')
                continue;

            $newPositions[] = $position;
        }

        return $newPositions;
    }
}

class Intersection
{
    public readonly Position $position;
    public array $connections;

    public function __construct(Position $position)
    {
        $this->position = $position;
    }

    function setConnections(Grid $grid, array $intersections, bool $climbSteepSlopes = false)
    {
        $this->connections = [];

        $visited = [];
        $positions = [$this->position];
        while (count($positions) > 0) {
            $position = array_pop($positions);

            if (isset($visited[$position->x][$position->y]))
                continue;

            if (isset($intersections[$position->x][$position->y]) && $intersections[$position->x][$position->y] !== $this) {
                $this->connections[] = $position;
                continue;
            }

            $visited[$position->x][$position->y] = true;

            foreach ($position->getNeighbours($grid, $climbSteepSlopes) as $nextPosition) {
                $positions[] = $nextPosition;
            }
        }
    }
}

class Hike
{
    public readonly Position $position;
    public readonly int $steps;
    public array $visited;

    public function __construct(Position $position, int $steps = 0)
    {
        $this->position = $position;
        $this->steps = $steps;
        $this->visited = [];
    }

    public static function createNext(Position $position, Hike $previous): Hike
    {
        $hike = new Hike($position, $previous->steps + $position->steps);
        foreach ($previous->visited as $x => $y) {
            foreach ($y as $y => $_) {
                $hike->visited[$x][$y] = true;
            }
        }
        $hike->visited[$previous->position->x][$previous->position->y] = true;

        return $hike;
    }

    public function hasVisited(Position $position): bool
    {
        return isset($this->visited[$position->x][$position->y]);
    }
}

function findLongestWalk(Grid $grid, array $intersections, bool $climbSteepSlopes = false) {
    $startPosition = null;
    foreach ($intersections as $_ => $yPositions) {
        foreach ($yPositions as $intersection) {
            $intersection->setConnections($grid, $intersections, $climbSteepSlopes);
            if ($intersection->position->y === 0)
                $startPosition = $intersection->position;
        }
    }

    $longest = 0;
    echo "$longest\n";

    $hikes = [new Hike($startPosition)];
    while (count($hikes) > 0) {
        $hike = array_pop($hikes);

        $intersection = $intersections[$hike->position->x][$hike->position->y];

        if ($intersection->position->y === $grid->maxY - 1) {
            if ($hike->steps > $longest) {
                $longest = $hike->steps;
                echo "\033[1A" . $longest . "\n";
            }
            continue;
        }

        foreach ($intersection->connections as $connection) {
            if ($hike->hasVisited($connection))
                continue;

            $hikes[] = Hike::createNext($connection, $hike);
        }
    }
}

$grid = file('input', FILE_IGNORE_NEW_LINES);

$grid = new Grid($grid);

$intersections = $grid->loadIntersections($grid);

findLongestWalk($grid, $intersections);
findLongestWalk($grid, $intersections, $climbSteepSlopes = true);
