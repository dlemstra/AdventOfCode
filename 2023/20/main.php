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
    private array $history = [];

    public function receivePulse(string $source, bool $value): iterable
    {
        $this->history[$source] = $value;

        $value = false;
        foreach ($this->history as $pulse) {
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

$lowCount = 0;
$highCount = 0;

for ($i = 0; $i < 1000; $i++) {
    $signals = [new Signal("button", false, "broadcaster")];
    while (count($signals) > 0) {
        $signal = array_shift($signals);

        if ($signal->value)
            $highCount++;
        else
            $lowCount++;

        if (!isset($modules[$signal->target]))
            continue;

        foreach ($modules[$signal->target]->receivePulse($signal->source, $signal->value) as $newSignal) {
            $signals[] = $newSignal;
        }
    }
}

echo $lowCount * $highCount . "\n";
