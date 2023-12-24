<?php

class Position
{
    public readonly float $x;
    public readonly float $y;

    public function __construct(float $x, float $y)
    {
        $this->x = $x;
        $this->y = $y;
    }
}

class StartingPoint
{
    public float $x;
    public float $y;
    public float $z;
    public float $xVelocity;
    public float $yVelocity;
    public float $zVelocity;

    public function __construct(float $x, float $y, float $z, float $xVelocity, float $yVelocity, float $zVelocity)
    {
        $this->x = $x;
        $this->y = $y;
        $this->z = $z;
        $this->xVelocity = $xVelocity;
        $this->yVelocity = $yVelocity;
        $this->zVelocity = $zVelocity;
    }

    public function findIntersectionXY(StartingPoint $other): ?Position
    {
        if ($this->xVelocity == 0 || $other->xVelocity == 0)
            return null;

        $a = ($this->yVelocity / $this->xVelocity);
        $b = ($other->yVelocity / $other->xVelocity);
        if ($a == $b)
            return null;

        $x = ($a * $this->x - $b * $other->x + $other->y - $this->y) / ($a - $b);
        $y = $a * ($x - $this->x) + $this->y;

        if (($x < $this->x && $this->xVelocity > 0) || ($x < $other->x && $other->xVelocity > 0) ||
            ($x > $this->x && $this->xVelocity < 0) || ($x > $other->x && $other->xVelocity < 0)
        )
            return null;


        if (($y < $this->y && $this->yVelocity > 0) || ($y < $other->y && $other->yVelocity > 0) ||
            ($y > $this->y && $this->yVelocity < 0) || ($y > $other->y && $other->yVelocity < 0)
        )
            return null;

        return new Position($x, $y);
    }

    public function calculateZVelocity(StartingPoint $other, Position $intersection): ?float
    {
        $m1 = $this->getMultiplication($intersection);
        $m2 = $other->getMultiplication($intersection);
        return ($this->z - $other->z + ($m1 * $this->zVelocity) - ($m2 * $other->zVelocity)) / ($m1 - $m2);
    }

    public function calculateZPosition(Position $intersection, float $zVelocity): float
    {
        return $this->z + $this->getMultiplication($intersection) * ($this->zVelocity - $zVelocity);
    }

    private function getMultiplication(Position $intersection): float
    {
        if ($this->xVelocity === 0)
            return ($intersection->y - $this->y) / $this->yVelocity;
        else
            return ($intersection->x - $this->x) / $this->xVelocity;
    }
}

function uniqueCombinations(array $points): iterable
{
    $indexes = range(0, count($points) - 1);
    for ($i = 0; $i < count($indexes); $i++) {
        for ($j = $i + 1; $j < count($indexes); $j++) {
            yield [$points[$i], $points[$j]];
        }
    }
}

function findStartingPoint(array $points): StartingPoint
{
    $count = 350;
    for ($x = -$count; $x < $count; $x++) {
        for ($y = -$count; $y < $count; $y++) {
            if ($x == 0 || $y == 0)
                continue;

            $first = clone $points[0];
            $first->xVelocity += $x;
            $first->yVelocity += $y;

            $other = clone $points[2];
            $other->xVelocity += $x;
            $other->yVelocity += $y;

            $intersectionA = $first->findIntersectionXY($other);
            if ($intersectionA === null)
                continue;

            $other = clone $points[1];
            $other->xVelocity += $x;
            $other->yVelocity += $y;

            $intersectionB = $first->findIntersectionXY($other);
            if ($intersectionB === null)
                continue;

            if ((int)($intersectionA->x - $intersectionB->x) !== 0 || (int)($intersectionA->y - $intersectionB->y) !== 0)
                continue;

            $zVelocity = $first->calculateZVelocity($other, $intersectionA);
            if (floor($zVelocity) !== $zVelocity)
                continue;

            $found = true;
            for ($i = 2; $i < count($points); $i++) {
                $next = clone $points[$i];
                $next->xVelocity += $x;
                $next->yVelocity += $y;

                if ($first->calculateZVelocity($other, $intersectionA) !== $zVelocity) {
                    $found = false;
                    break;
                }
            }

            if ($found)
                return new StartingPoint($intersectionA->x, $intersectionA->y, $first->calculateZPosition($intersectionA, $zVelocity), -$x, -$y, $zVelocity);
        }
    }

    throw new Exception('Not found');
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$points = [];
foreach ($lines as $index => $line) {
    $parts = explode(' @ ', $line);
    $positions = array_map('intval', explode(', ', $parts[0]));
    $velocities = array_map('intval', explode(', ', $parts[1]));
    $points[] = new StartingPoint($positions[0], $positions[1], $positions[2], $velocities[0], $velocities[1], $velocities[2]);
}

$min = 200000000000000;
$max = 400000000000000;

$collisions = 0;
foreach (uniqueCombinations($points) as $combination) {
    $first = $combination[0];
    $second = $combination[1];
    $intersection = $first->findIntersectionXY($second);
    if ($intersection !== null) {
        if ($intersection->x >= $min && $intersection->x < $max && $intersection->y >= $min && $intersection->y < $max) {
            $collisions++;
        }
    }
}

echo $collisions . "\n";

$startingPoint = findStartingPoint($points);
echo number_format($startingPoint->x + $startingPoint->y + $startingPoint->z, 0, '', '') . "\n";
