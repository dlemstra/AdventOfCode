<?php

class Node
{
    public $id;
    public $connections = [];

    public function __construct($id)
    {
        $this->id = $id;
    }
}

function countMovesToExit(array $nodes, string $id, string $moves, callable $callback)
{
    $i = 0;
    $node = $nodes[$id];
    while (true) {
        $direction = $moves[$i % strlen($moves)];
        $node = $nodes[$node->connections[$direction]];
        $i++;
        if ($callback($node->id) === true) {
            return $i;
        }
    }
}

function lcm(int $a, int $b)
{
    $gcd = function ($a, $b) use (&$gcd) {
        return ($a % $b) ? $gcd($b, $a % $b) : $b;
    };

    return abs($a * $b) / $gcd($a, $b);
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$moves = $lines[0];

$nodes = [];
$starts = [];
for ($i = 2; $i < count($lines); $i++) {
    $line = $lines[$i];
    $info = explode(' = ', $line);
    $id = $info[0];
    $connections = explode(', ', str_replace(['(', ')'], '', $info[1]));
    $node = new Node($id);
    $node->connections['L'] = $connections[0];
    $node->connections['R'] = $connections[1];
    $nodes[$id] = $node;
    if ($id[2] == 'A') {
        $starts[] = $id;
    }
}

$part1 = countMovesToExit($nodes, 'AAA', $moves, function ($id) {
    return $id == 'ZZZ';
});

echo $part1 . "\n";

$part2 = countMovesToExit($nodes, $starts[0], $moves, function ($id) {
    return $id[2] == 'Z';
});

for ($i = 1; $i < count($starts); $i++) {
    $part2 = lcm($part2, countMovesToExit($nodes, $starts[$i], $moves, function ($id) {
        return $id[2] == 'Z';
    }));
}

echo $part2 . "\n";
