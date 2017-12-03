package main

import (
    "fmt"
)

func prev(intput int) int {
    if intput > 0 {
        return intput - 1
    }
    return 3
}

func min(a, b int) int {
    if a <= b {
        return a
    }
    return b
}

func SpiralMemory(input int) int {
    directions := []int {1, 1, 1, 1}
    stepSize := -1
    steps := 0

    for input > directions[0] {
        steps++
        for i:=0; i < 4; i++ {
            stepSize += 2
            directions[i] += stepSize
            if directions[i] >= input {
                cur  := steps + directions[i] - input
                prev := steps + input - directions[prev(i)]
                if i == 0 {
                    prev--
                }
                return min(cur, prev)
            }
        }
    }

    return steps;
}

func main() {
    result := SpiralMemory(325489)
    fmt.Println(result)
}