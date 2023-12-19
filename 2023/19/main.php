<?php

class Rule
{
    public readonly string $target;
    public readonly string $part;
    public readonly int $value;
    public readonly bool $checkLess;

    public function __construct(string $target, string $part = "", bool $checkLess = false, int $value = 0)
    {
        $this->target = $target;
        $this->part = $part;
        $this->value = $value;
        $this->checkLess = $checkLess;
    }

    public static function parse(string $rule): Rule
    {
        $parts = explode(':', $rule);
        if (count($parts) == 1)
            return new Rule($parts[0]);

        $target = $parts[1];
        $part = $parts[0][0];
        $checkLess = $parts[0][1] === '<';
        $value = (int)substr($parts[0], 2);

        return new Rule($target, $part, $checkLess, $value);
    }

    public function matches(array $values): bool
    {
        return $this->part === "" ||
            ($this->checkLess && $values[$this->part] < $this->value) ||
            (!$this->checkLess && $values[$this->part] > $this->value);
    }
}

class Range
{
    public readonly string $part;
    public readonly int $min;
    public readonly int $max;
    public readonly string $target;

    public function __construct(string $part, int $min = 1, int $max = 4000, string $target = "in")
    {
        $this->part = $part;
        $this->min = $min;
        $this->max = $max;
        $this->target = $target;
    }
}

class WorkFlow
{
    public readonly string $name;
    private array $rules;

    public function __construct(string $name)
    {
        $this->name = $name;
    }

    public function addRule(Rule $rule): void
    {
        $this->rules[] = $rule;
    }

    public function getNextTarget(array $values): string
    {
        foreach ($this->rules as $rule) {
            if ($rule->matches($values))
                return $rule->target;
        }

        throw new Exception("No matching rule found");
    }

    public function getRanges(array $ranges): iterable
    {
        foreach ($this->rules as $rule) {
            $newRanges = [];
            $remainingRanges = [];
            foreach ($ranges as $range) {
                $newRange = new Range($range->part, $range->min, $range->max, $rule->target);
                if ($range->part !== $rule->part) {
                    $newRanges[] = $newRange;
                    $remainingRanges[] = $newRange;
                } else {
                    if ($rule->checkLess && $range->min < $rule->value) {
                        $newRanges[] = new Range($range->part, $range->min, $rule->value - 1, $rule->target);
                        $remainingRanges[] = new Range($range->part, $rule->value, $range->max, $range->target);
                    } else if (!$rule->checkLess && $range->max > $rule->value) {
                        $newRanges[] = new Range($range->part, $rule->value + 1, $range->max, $rule->target);
                        $remainingRanges[] = new Range($range->part, $range->min, $rule->value, $range->target);
                    } else {
                        $newRanges[] = $newRange;
                    }
                }
            }
            yield $newRanges;
            $ranges = $remainingRanges;
        }
    }
}

function countAcceptedRanges($workflows, $ranges): int
{
    $rangesByTarget = [];
    foreach ($ranges as $range) {
        $target = $range->target;
        if (!isset($rangesByTarget[$target])) {
            $rangesByTarget[$target] = [];
        }
        $rangesByTarget[$target][] = $range;
    }

    $total = 0;
    foreach ($rangesByTarget as $name => $ranges) {
        if ($name === "R")
            continue;

        if ($name === "A") {
            $subTotal = 1;
            foreach ($ranges as $range)
                $subTotal *= $range->max - $range->min + 1;
            $total += $subTotal;
            continue;
        }

        $workflow = $workflows[$name];
        foreach ($workflow->getRanges($ranges) as $newRanges) {
            $total  += countAcceptedRanges($workflows, $newRanges);
        }
    }

    return $total;
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$workflows = [];
foreach ($lines as $index => $line) {
    if ($line === '')
        break;

    $parts = explode('{', substr($line, 0, -1));
    $workflow = new WorkFlow($parts[0]);
    foreach (explode(',', $parts[1]) as $rule) {
        $workflow->addRule(Rule::parse($rule));
    }
    $workflows[$workflow->name] = $workflow;
}

$part1 = 0;
for ($i = $index + 1; $i < count($lines); $i++) {
    $line = substr($lines[$i], 1, -1);
    $parts = explode(',', $line);
    $values = [];
    foreach ($parts as $part) {
        $values[$part[0][0]] = (int)substr($part, 2);
    }

    $target = $workflows["in"]->getNextTarget($values);
    while ($target !== "A" && $target !== "R") {
        $target = $workflows[$target]->getNextTarget($values);
    }

    if ($target === "A")
        $part1 += array_sum($values);
}

echo $part1 . "\n";

$ranges = [new Range("x"), new Range("m"), new Range("a"), new Range("s")];
echo countAcceptedRanges($workflows, $ranges) . "\n";
