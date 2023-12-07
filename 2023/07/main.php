<?php

const cards = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'];

class Hand
{
    public $hand;
    private $score = 0;
    public $bid;

    public function __construct($hand, $bid)
    {
        $this->hand = $hand;
        $this->bid = $bid;
        $this->setScore();
    }

    function compare($other)
    {
        if ($this->score < $other->score) {
            return -1;
        } elseif ($this->score > $other->score) {
            return 1;
        } else {
            for ($i = 0; $i < strlen($this->hand); $i++) {
                $indexA = array_search($this->hand[$i], cards);
                $indexB = array_search($other->hand[$i], cards);
                if ($indexA < $indexB) {
                    return 1;
                } elseif ($indexA > $indexB) {
                    return -1;
                }
            }
        }
    }

    private function setScore()
    {
        $counts = [];
        foreach (str_split($this->hand) as $card) {
            if (!isset($counts[$card]))
                $counts[$card] = 0;
            $counts[$card]++;
        }

        $this->score = 0;
        switch (count($counts)) {
            case 4:
                $this->score = 1;
                break;
            case 3:
                $this->score = 2;
                foreach ($counts as $card => $count) {
                    if ($count == 3) {
                        $this->score = 3;
                        break;
                    }
                }
                break;
            case 2:
                $this->score = 4;
                foreach ($counts as $card => $count) {
                    if ($count == 4) {
                        $this->score = 5;
                        break;
                    }
                }
                break;
            case 1:
                $this->score = 6;
                break;
        }
    }
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$hands = [];
foreach ($lines as $line) {
    $parts = explode(' ', $line);
    $hands[] = new Hand($parts[0], $parts[1]);
}

usort($hands, function ($a, $b) {
    return $a->compare($b);
});

$total = 0;
for ($i = 0; $i < count($hands); $i++) {
    $total += $hands[$i]->bid * ($i + 1);
}

echo $total . "\n";
