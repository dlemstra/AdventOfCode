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

$lines = file('input', FILE_IGNORE_NEW_LINES);

$moves = $lines[0];

$nodes = [];
for ($i = 2; $i < count($lines); $i++) {
    $line = $lines[$i];
    $info = explode(' = ', $line);
    $id = $info[0];
    $connections = explode(', ', str_replace(['(', ')'], '', $info[1]));
    $node = new Node($id);
    $node->connections['L'] = $connections[0];
    $node->connections['R'] = $connections[1];
    $nodes[$id] = $node;
}

$node = $nodes['AAA'];
$i = 0;
while ($node->id != 'ZZZ') {
    $direction = $moves[$i % strlen($moves)];
    $node = $nodes[$node->connections[$direction]];
    $i++;
}

echo $i . "\n";
