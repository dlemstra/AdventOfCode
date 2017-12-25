package main

import (
    "fmt"
    "os"
    "bufio"
    "strings"
    "strconv"
)

type Instruction struct {
    target string
    increment int
    other string
    compareType string
    compareValue int
}

func max(values map[string]int) int {
    max := 0
    for _, value := range values {
        if (value > max) {
            max = value
        }
    }

    return max
}

func isConditionTrue(instruction Instruction, values map[string]int) bool {
    compareValue := values[instruction.other]
    switch compareType := instruction.compareType; compareType {
        case ">":
            return compareValue > instruction.compareValue
        case ">=":
            return compareValue >= instruction.compareValue
        case "<":
            return compareValue < instruction.compareValue
        case "<=":
            return compareValue <= instruction.compareValue
        case "==":
            return compareValue == instruction.compareValue
        case "!=":
            return compareValue != instruction.compareValue
        default:
            panic("unknown instruction")
    }
}

func LikeRegisters(instructions []Instruction) int {
    values := make(map[string]int)

    for _,instruction := range instructions {
        if isConditionTrue(instruction, values) {
            values[instruction.target] += instruction.increment
        }
    }

    return max(values)
}

func ReadInput(fileName string) []Instruction {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := []Instruction {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := strings.Split(scanner.Text(), " if ")
        start := strings.Split(line[0], " ")
        end := strings.Split(line[1], " ")

        target := start[0]
        increment,_ := strconv.Atoi(start[2])
        if (start[1] == "dec") {
            increment *= -1
        }
        other := end[0]
        compareType := end[1]
        compareValue,_ := strconv.Atoi(end[2])

        Instruction := Instruction {
            target: target,
            increment: increment,
            other : other,
            compareType: compareType,
            compareValue: compareValue,
        }
        result = append(result, Instruction)
    }

    return result
}

func main() {
    input := ReadInput("../input")
    result := LikeRegisters(input)
    fmt.Println(result)
}