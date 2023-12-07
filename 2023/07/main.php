<?php

const cards1 = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'];
const cards2 = ['A', 'K', 'Q', 'T', '9', '8', '7', '6', '5', '4', '3', '2', 'J'];

class Hand
{
    private $hand;
    private $score1 = 0;
    private $score2 = 0;
    public $bid;

    public function __construct($hand, $bid)
    {
        $this->hand = $hand;
        $this->bid = $bid;
        $this->setScore();
    }

    function compare1(Hand $other)
    {
        if ($this->score1 < $other->score1) {
            return -1;
        } elseif ($this->score1 > $other->score1) {
            return 1;
        } else {
            return $this->compareHand($other, cards1);
        }
    }

    function compare2(Hand $other)
    {
        if ($this->score2 < $other->score2) {
            return -1;
        } elseif ($this->score2 > $other->score2) {
            return 1;
        } else {
            return $this->compareHand($other, cards2);
        }
    }

    private function compareHand(Hand $other, array $cards)
    {
        for ($i = 0; $i < strlen($this->hand); $i++) {
            $indexA = array_search($this->hand[$i], $cards);
            $indexB = array_search($other->hand[$i], $cards);
            if ($indexA < $indexB) {
                return 1;
            } elseif ($indexA > $indexB) {
                return -1;
            }
        }

        return 0;
    }

    private function setScore()
    {
        $counts = [];
        foreach (str_split($this->hand) as $card) {
            if (!isset($counts[$card]))
                $counts[$card] = 0;
            $counts[$card]++;
        }

        $this->score1 = $this->getScore($counts);

        arsort($counts);

        if (isset($counts['J'])) {
            $jokerCount = $counts['J'];
            unset($counts['J']);
            $counts[key($counts)] += $jokerCount;
        }

        $this->score2 = $this->getScore($counts);
    }

    private function getScore(array $counts)
    {
        $score = 0;
        switch (count($counts)) {
            case 4:
                $score = 1;
                break;
            case 3:
                $score = 2;
                foreach ($counts as $card => $count) {
                    if ($count == 3) {
                        $score = 3;
                        break;
                    }
                }
                break;
            case 2:
                $score = 4;
                foreach ($counts as $card => $count) {
                    if ($count == 4) {
                        $score = 5;
                        break;
                    }
                }
                break;
            case 1:
                $score = 6;
                break;
        }

        return $score;
    }
}

function getTotal(array $hands)
{
    $total = 0;
    for ($i = 0; $i < count($hands); $i++) {
        $total += $hands[$i]->bid * ($i + 1);
    }

    return $total;
}

$lines = file('input', FILE_IGNORE_NEW_LINES);

$hands = [];
foreach ($lines as $line) {
    $parts = explode(' ', $line);
    $hands[] = new Hand($parts[0], $parts[1]);
}

usort($hands, function (Hand $a, Hand $b) {
    return $a->compare1($b);
});

$part1 = getTotal($hands);
echo $part1 . "\n";

usort($hands, function (Hand $a, Hand $b) {
    return $a->compare2($b);
});

$part2 =  getTotal($hands);
echo $part2 . "\n";
