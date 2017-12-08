package main

import (
    "fmt"
)

type Instruction struct {
    target string
    increment int
    other string
    compareType string
    compareValue int
}

func LikeRegisters(instructions []Instruction) int {
    return 42
}

func ReadInput(fileName string) []Instruction {
    result := []Instruction {}

    return result
}

func main() {
    input := ReadInput("../input")
    result := LikeRegisters(input)
    fmt.Println(result)
}