<?php

function dfs($residualGraph, $source, $destination, &$parent, $count): bool
{
    $visited = array_fill(0, $count, false);
    $queue = [$source];
    $visited[$source] = true;

    while (count($queue) > 0) {
        $name = array_pop($queue);

        foreach ($residualGraph[$name] as $target => $capacity) {
            if (!isset($visited[$target]) && $capacity > 0) {
                $queue[] = $target;
                $parent[$target] = $name;
                $visited[$target] = true;
            }
        }
    }

    return $visited[$destination] ?? false;
}

function fordFulkerson($graph, $source, $destination, $count): int
{
    $residualGraph = $graph;
    $parent = array_fill(0, $count, -1);
    $maxFlow = 0;

    while (dfs($residualGraph, $source, $destination, $parent, $count)) {
        $pathFlow = PHP_INT_MAX;
        for ($name = $destination; $name != $source; $name = $parent[$name]) {
            $target = $parent[$name];
            $pathFlow = min($pathFlow, $residualGraph[$target][$name]);
        }

        for ($name = $destination; $name != $source; $name = $parent[$name]) {
            $target = $parent[$name];
            $residualGraph[$target][$name] -= $pathFlow;
            $residualGraph[$name][$target] += $pathFlow;
        }

        $maxFlow += $pathFlow;
    }

    return $maxFlow;
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$connections = [];
foreach ($lines as $line) {
    $parts = explode(': ', $line);
    $source = $parts[0];
    $destinations = explode(' ', $parts[1]);

    foreach ($destinations as $destination) {
        $connections[$source][$destination] = 1;
        $connections[$destination][$source] = 1;
    }
}

$names = array_keys($connections);
$start = $names[0];
$found = 0;
$total = count($names);

foreach ($names as $name) {
    if ($name == $start)
        continue;

    $count = fordFulkerson($connections, $start, $name, $total);
    if ($count == 3)
        $found++;
}

echo $found * ($total - $found) . "\n";
