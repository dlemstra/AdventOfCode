<?php

class Item
{
    public $start;
    public $end;

    public function __construct(int $start, int $end)
    {
        $this->start = $start;
        $this->end = $end;
    }

    function delta(): int
    {
        return $this->end - $this->start;
    }

    public function setEnd(int $end)
    {
        $this->start = $this->end;
        $this->end = $end;
    }
}

function calculateNext(array $sequence): int
{
    $count = count($sequence) - 1;

    $sequenceIndex = 3;
    $items = [new Item($sequence[1] - $sequence[0], $sequence[2] - $sequence[1])];

    while ($count-- > 2) {
        $prev = $items[count($items) - 1];
        $start = $prev->delta();
        for ($i = 0; $i < count($items); $i++) {
            if ($i === 0) {
                $value = $sequence[$sequenceIndex] - $sequence[$sequenceIndex - 1];
                $sequenceIndex++;
            } else {
                $value = $items[$i - 1]->delta();
            }
            $items[$i]->setEnd($value);
        }
        $end = $prev->delta();

        $items[] = new Item($start, $end);
    }

    for ($i = count($items) - 1; $i > 0; $i--) {
        $items[$i - 1]->setEnd($items[$i - 1]->end + $items[$i]->end);
    }

    return $sequence[$sequenceIndex - 1] + $items[0]->end;
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$part1 = 0;
$part2 = 0;
foreach ($lines as $line) {
    $sequence = explode(' ', $line);
    $part1 += calculateNext($sequence);
    $part2 += calculateNext(array_reverse($sequence));
}

echo $part1 . "\n";
echo $part2 . "\n";
