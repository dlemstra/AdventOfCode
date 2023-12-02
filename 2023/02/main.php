<?php

$lines = file('input');

$total = 0;
foreach ($lines as $line) {
    $info = explode(': ', $line);
    $reveals = explode('; ', $info[1]);
    $possible = true;
    foreach ($reveals as $revealed) {
        $cubes = explode(', ', $revealed);
        $red = $green = $blue = 0;
        foreach ($cubes as $cube) {
            $cube = explode(' ', $cube);
            switch (trim($cube[1])) {
                case 'red':
                    $red = $cube[0];
                    break;
                case 'green':
                    $green = $cube[0];
                    break;
                case 'blue':
                    $blue = $cube[0];
                    break;
            }
        }
        if ($red > 12 || $green > 13 || $blue > 14) {
            $possible = false;
            break;
        }
    }

    if ($possible === true) {
        $id = explode(' ', $info[0])[1];
        $total += $id;
    }
}

echo $total . "\n";
