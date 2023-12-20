<?php

abstract class Module
{
    public int $lowCount = 0;
    public int $highCount = 0;
    public array $targets;
    public readonly string $name;

    public function __construct(string $name, array $targets)
    {
        $this->name = $name;
        $this->targets = $targets;
    }

    static function create(string $line): Module
    {
        $parts = explode(' -> ', $line);

        $name = $parts[0];
        $targets = explode(', ', $parts[1]);

        if ($name[0] == '%') {
            $name = substr($name, 1);
            return new FlipFlop($name, $targets);
        } else if ($name[0] == '&') {
            $name = substr($name, 1);
            return new Conjunction($name, $targets);
        } else {
            return new Broadcaster($name, $targets);
        }
    }

    abstract function receivePulse(string $source, bool $value): iterable;
}

class Broadcaster extends Module
{
    public function __construct(string $name, array $targets)
    {
        parent::__construct($name, $targets);
    }

    public function receivePulse(string $source, bool $value): iterable
    {
        foreach ($this->targets as $target) {
            yield new Signal($this->name, $value, $target);
        }
    }
}

class FlipFlop extends Module
{
    private bool $value = false;

    public function __construct(string $name, array $targets)
    {
        parent::__construct($name, $targets);
    }

    public function receivePulse(string $source, bool $value): iterable
    {
        if ($value !== false)
            return;

        $this->value = !$this->value;

        foreach ($this->targets as $target) {
            yield new Signal($this->name, $this->value, $target);
        }
    }
}

class Conjunction extends Module
{
    public array $inputs = [];

    public function receivePulse(string $source, bool $value): iterable
    {
        $this->inputs[$source] = $value;

        $value = false;
        foreach ($this->inputs as $pulse) {
            if ($pulse === false) {
                $value = true;
                break;
            }
        }

        foreach ($this->targets as $target) {
            yield new Signal($this->name, $value, $target);
        }
    }
}

class Signal
{
    public string $source;
    public bool $value;
    public string $target;

    public function __construct(string $source, bool $value, string $target)
    {
        $this->source = $source;
        $this->value = $value;
        $this->target = $target;
    }
}

function findRxParent($modules): string
{
    foreach ($modules as $module) {
        if (array_search("rx", $module->targets) !== false) {
            return $module->name;
        }
    }

    throw new Error("No parent found");
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$modules = [];
foreach ($lines as $line) {
    $module = Module::create($line);
    $modules[$module->name] = $module;
}

foreach ($modules as $module) {
    if (get_class($module) == "Conjunction") {
        foreach ($modules as $other) {
            if (array_search($module->name, $other->targets) !== false)
                foreach ($module->receivePulse($other->name, false) as $_) {
                }
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

$lowCount = 0;
$highCount = 0;
$rxParent = findRxParent($modules);
$rxParentInputCount = count($modules[$rxParent]->inputs);
$rxParentHigh = [];
$rxParentDone = 0;

$part1 = 0;

for ($i = 0; $i < 10000; $i++) {
    $signals = [new Signal("button", false, "broadcaster")];
    while (count($signals) > 0) {
        $signal = array_shift($signals);

        if ($signal->value)
            $highCount++;
        else
            $lowCount++;

        if ($signal->value && $signal->target == $rxParent) {
            if (!isset($rxParentHigh[$signal->source]))
                $rxParentHigh[$signal->source] = $i;
            else {
                $rxParentHigh[$signal->source] = $i - $rxParentHigh[$signal->source];
                $rxParentDone++;
            }
        }

        if (!isset($modules[$signal->target]))
            continue;

        foreach ($modules[$signal->target]->receivePulse($signal->source, $signal->value) as $newSignal) {
            $signals[] = $newSignal;
        }
    }

    if ($i == 999)
        $part1 = $lowCount * $highCount . "\n";

    if ($rxParentDone == $rxParentInputCount) {
        break;
    }
}

echo $part1;

$part2 = 1;
$values = array_values($rxParentHigh);
for ($i = 0; $i < count($values); $i++) {
    $part2 = lcm($part2, $values[$i]);
}

echo $part2 . "\n";
