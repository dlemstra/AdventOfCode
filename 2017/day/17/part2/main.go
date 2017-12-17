package main

import (
    "fmt"
)

func Spinlock(input int, iterations int) int {
    last := 0

    index := 0
    for i:=1; i < iterations; i++ {
        index = (index + input) % i + 1

        if index == 1 {
            last = i
        }
    }

    return last
}

func main() {
    result := Spinlock(386, 50000000)
    fmt.Println(result)
}