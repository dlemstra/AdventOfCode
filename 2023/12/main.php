<?php

class Solver
{
    private $cache = [];
    private $counts = [];
    private $pattern = "";

    public function __construct(string $pattern, array $counts, int $times)
    {
        for ($i = 0; $i < $times; $i++) {
            if ($i > 0)
                $this->pattern .= "?";

            $this->pattern .= $pattern;
            $this->counts = array_merge($this->counts, $counts);
        }
    }

    public function solve(): int
    {
        return $this->countPossibilities($this->pattern, $this->counts);
    }

    private function countPossibilities($pattern, $counts, $groupMemberCount = 0)
    {
        if ($pattern == "") {
            $count = count($counts);
            return ($count == 0 & $groupMemberCount == 0) || ($count == 1 && $counts[0] == $groupMemberCount);
        }

        $cacheKey = $pattern . "[" . implode(",", $counts) . "]" . $groupMemberCount;
        if (isset($this->cache[$cacheKey]))
            return $this->cache[$cacheKey];

        $count = 0;
        $remaining = substr($pattern, 1);
        switch ($pattern[0]) {
            case "?":
                $count = $this->countPossibilities("#" . $remaining, $counts, $groupMemberCount);
                $count += $this->countPossibilities("." . $remaining, $counts, $groupMemberCount);
                break;
            case "#":
                $count = $this->countPossibilities($remaining, $counts, $groupMemberCount + 1);
                break;
            case ".":
                if ($groupMemberCount > 0) {
                    if (!empty($counts) && $counts[0] == $groupMemberCount) {
                        $count = $this->countPossibilities($remaining, array_slice($counts, 1));
                    }
                } else {
                    $count = $this->countPossibilities($remaining, $counts);
                }
                break;
        }

        $this->cache[$cacheKey] = $count;
        return $count;
    }
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$part1 = 0;
$part2 = 0;
foreach ($lines as $line) {
    $parts = explode(' ', $line);

    $solver = new Solver($parts[0], explode(',', $parts[1]), 1);
    $part1 += $solver->solve();

    $solver = new Solver($parts[0], explode(',', $parts[1]), 5);
    $part2 += $solver->solve();
}

echo $part1 . "\n";
echo $part2 . "\n";
