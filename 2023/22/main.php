<?php

class Cube
{
    public readonly int $x;
    public readonly int $y;
    public int $z;

    public function __construct(int $x, int $y, int $z)
    {
        $this->x = $x;
        $this->y = $y;
        $this->z = $z;
    }

    public function moveUp()
    {
        $this->z++;
    }

    public function moveDown(): bool
    {
        if ($this->z === 0) {
            return false;
        }

        $this->z--;
        return true;
    }

    static public function create(string $string): Cube
    {
        $parts = explode(',', $string);
        return new Cube($parts[0], $parts[1], $parts[2]);
    }
}

class Brick
{
    public readonly int $id;
    public Cube $start;
    public Cube $end;
    private bool $done = false;

    public function __construct(int $id, Cube $start, Cube $end)
    {
        $this->id = $id;
        $this->start = $start;
        $this->end = $end;
        $this->checkDone();
    }

    public function checkDone()
    {
        $this->done = $this->start->z === 1;
    }

    public function checkCollision(Brick $other) {
        return $this->start->x <= $other->end->x && $this->end->x >= $other->start->x
            && $this->start->y <= $other->end->y && $this->end->y >= $other->start->y
            && $this->start->z <= $other->end->z && $this->end->z >= $other->start->z;
    }

    public function moveDown(array $bricks): bool
    {
        if ($this->done) {
            return false;
        }

        $this->start->moveDown();
        $this->end->moveDown();

        $canMoveDown = true;
        foreach ($bricks as $brick) {
            if ($brick->id === $this->id || $brick->end->z !== $this->start->z) continue;
            if ($this->checkCollision($brick)) {
                $canMoveDown = false;
                break;
            }
        }

        if (!$canMoveDown) {
            $this->start->moveUp();
            $this->end->moveUp();
            $this->done = true;
        }

        $this->checkDone();

        return $canMoveDown;
    }
}

function moveBricksDown(&$bricks, bool $earlyExit = false): bool
{
    $moved = false;
    foreach ($bricks as $brick) {
        $moved = $brick->moveDown($bricks) || $moved;
        if ($earlyExit && $moved) break;
    }

    return $moved;
}

function removeBrick(array $bricks): iterable
{
    foreach ($bricks as $brick) {
        $newBricks = [];
        foreach($bricks as $other) {
            if ($other->id !== $brick->id) {
                $newBricks[] = new Brick($other->id, clone $other->start, clone $other->end);
            }
        }
        yield $newBricks;
    }
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$bricks = [];
foreach ($lines as $line) {
    $parts = explode('~', $line);

    $id = count($bricks);
    $begin = Cube::create($parts[0]);
    $end = Cube::create($parts[1]);
    $bricks[$id] = new Brick($id, $begin, $end);
}

usort($bricks, function (Brick $a, Brick $b) {
    return $a->start->z <=> $b->start->z;
});

while (moveBricksDown($bricks));

echo "0\n";

$count = 0;
foreach (removeBrick($bricks) as $updatedBricks) {
    if (!moveBricksDown($updatedBricks, earlyExit: true))
        $count++;
    echo "\033[1A" . $count . "\n";
}
echo "\033[1A\n";
