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

$lines = file('input', FILE_IGNORE_NEW_LINES);

$part1 = 0;
foreach ($lines as $line) {
    $sequence = explode(' ', $line);
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

    $part1 += $sequence[$sequenceIndex - 1] + $items[0]->end;
}

echo $part1 . "\n";
