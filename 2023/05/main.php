<?php

class Range
{
    public $start;
    public $end;
    public $delta;

    public function __construct($start, $end, $delta)
    {
        $this->start = $start;
        $this->end = $end;
        $this->delta = $delta;
    }

    function done()
    {
        return $this->start === -1;
    }

    function overlapping($other)
    {
        if ($other->start >= $this->start && $other->start <= $this->end) {
            $start = $other->start;
            $end = $other->end;
            if ($other->end > $this->end) {
                $other->start = $this->end + 1;
                $end = $this->end;
            } else {
                $other->start = -1;
            }
            return new Range($start + $this->delta, $end + $this->delta, 0);
        } else if ($other->end >= $this->start && $other->end <= $this->end) {
            $start = $other->start;
            $end = $other->end;
            if ($other->start < $this->start) {
                $other->end = $this->start - 1;
                $start = $this->start;
            } else {
                $other->start = -1;
            }
            return new Range($start + $this->delta, $end + $this->delta, 0);
        }

        return null;
    }
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$seeds = explode(' ', substr($lines[0], 7));

$groups = [];
$ranges = [];
for ($i = 3; $i < count($lines); $i++) {
    if ($lines[$i] === '') {
        $groups[] = $ranges;
        $ranges = [];
        $i += 1;
        continue;
    }

    $info = array_map('intval', explode(' ', $lines[$i]));
    $ranges[] = new Range($info[1], $info[1] + $info[2] - 1, $info[0] - $info[1]);
}
$groups[] = $ranges;

$part1 = 2147483647;
$items = [];
for ($i = 0; $i < count($seeds); $i++) {
    if ($i % 2 == 0) {
        $items[] = new Range($seeds[$i], $seeds[$i] + $seeds[$i + 1] - 1, 0);
    }
    $seed = $seeds[$i];
    foreach ($groups as $group) {
        foreach ($group as $range) {
            if ($seed >= $range->start && $seed <= $range->end) {
                $seed += $range->delta;
                break;
            }
        }
    }

    $part1 = min($part1, $seed);
}

echo $part1 . "\n";

foreach ($groups as $group) {
    $possible = [];
    foreach ($items as $item) {
        foreach ($group as $range) {
            $overlapping = $range->overlapping($item);
            if ($overlapping !== null) {
                $possible[] = $overlapping;
            }
            if ($item->done() !== false) {
                break;
            }
        }
    }
    foreach ($items as $item) {
        if ($item->done() === false) {
            $possible[] = $item;
        }
    }
    $items = $possible;
}

$part2 = 2147483647;
foreach ($items as $item) {
    $part2 = min($part2, $item->start);
}

echo $part2 . "\n";
