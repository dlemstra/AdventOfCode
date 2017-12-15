package main

import (
    "fmt"
)

func nextValue(value int64, factor int64) int64 {
    return  (value * factor % 2147483647)
}

func DuelingGenerators(a int64, b int64, count int) int {
    factorA := int64(16807)
    factorB := int64(48271)

    matches := 0

    for i:=0; i < count; i++ {
        for a % 4 != 0 {
            a = nextValue(a, factorA)
        }
        for b % 8 != 0 {
            b = nextValue(b, factorB)
        }

        if (a & 0xffff == b & 0xffff) {
            matches++
        }

        a = nextValue(a, factorA)
        b = nextValue(b, factorB)
    }

    return matches
}

func main() {
    result := DuelingGenerators(883, 879, 5000000)
    fmt.Println(result)
}