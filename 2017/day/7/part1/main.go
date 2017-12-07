package main

import (
    "fmt"
)

type Tower struct {
    name string
    weight int
    childNames []string
    children []Tower
}

func RecursiveCircus(input []Tower) string {
    return "42"
}

func ReadInput(fileName string) []Tower {
    result := make([]Tower, 0)

    return result
}

func main() {
    input := ReadInput("../input")
    result := RecursiveCircus(input)
    fmt.Println(result)
}