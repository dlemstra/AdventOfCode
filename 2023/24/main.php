<?

class Line
{
    private float $startX;
    private float $startY;
    private float $xVelocity;
    private float $yVelocity;

    public function __construct(float $startX, float $startY, int $xVelocity, int $yVelocity)
    {
        $this->startX = $startX;
        $this->startY = $startY;
        $this->xVelocity = $xVelocity;
        $this->yVelocity = $yVelocity;
    }

    public function findIntersection(Line $other)
    {
        $a = ($this->yVelocity / $this->xVelocity);
        $b = ($other->yVelocity / $other->xVelocity);
        if ($a == $b)
            return null;

        $x = ($a * $this->startX - $b * $other->startX + $other->startY - $this->startY) / ($a - $b);
        $y = $a * ($x - $this->startX) + $this->startY;

        if (($x < $this->startX && $this->xVelocity > 0) || ($x < $other->startX && $other->xVelocity > 0) ||
            ($x > $this->startX && $this->xVelocity < 0) || ($x > $other->startX && $other->xVelocity < 0)
        )
            return null;

        if (($y < $this->startY && $this->yVelocity > 0) || ($y < $other->startY && $other->yVelocity > 0) ||
            ($y > $this->startY && $this->yVelocity < 0) || ($y > $other->startY && $other->yVelocity < 0)
        )
            return null;

        return [$x, $y];
    }
}

function uniqueCombinations(array $items): iterable
{
    for ($i = 0; $i < count($items); $i++) {
        for ($j = $i + 1; $j < count($items); $j++) {
            yield [$items[$i], $items[$j]];
        }
    }
}

$input = file('input', FILE_IGNORE_NEW_LINES);

$lines = [];
foreach ($input as $index => $line) {
    $parts = explode(' @ ', $line);
    $positions = array_map('intval', explode(', ', $parts[0]));
    $velocities = array_map('intval', explode(', ', $parts[1]));
    $lines[] = new Line($positions[0], $positions[1], $velocities[0], $velocities[1]);
}

$min = 200000000000000;
$max = 400000000000000;

$collisions = 0;
foreach (uniqueCombinations(range(0, count($lines) - 1)) as $combination) {
    $first = $lines[$combination[0]];
    $second = $lines[$combination[1]];
    $pointOfCollision = $first->findIntersection($second);
    if ($pointOfCollision !== null) {
        if ($pointOfCollision[0] >= $min && $pointOfCollision[0] < $max && $pointOfCollision[1] >= $min && $pointOfCollision[1] < $max) {
            $collisions++;
        }
    }
}

echo $collisions . "\n";
