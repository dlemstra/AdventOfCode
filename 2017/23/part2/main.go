package main

import (
    "fmt"
    "os"
    "bufio"
    "strings"
    "strconv"
)

type Instruction struct {
    name string
    x string
    y string
}

func getValue(registers map[string]int, value string) int {
    val, err := strconv.Atoi(value)
    if err == nil {
        return val
    }

    return registers[value]
}

func executeInstruction(registers map[string]int, instruction Instruction) int {
    increment := 1
    switch (instruction.name) {
        case "set":
            registers[instruction.x] = getValue(registers, instruction.y)
        case "sub":
            registers[instruction.x] = getValue(registers, instruction.x) - getValue(registers, instruction.y)
        case "mul":
            registers[instruction.x] = getValue(registers, instruction.x) * getValue(registers, instruction.y)
        case "jnz":
            if getValue(registers, instruction.x) != 0 {
                increment = getValue(registers, instruction.y)
            }
    }
    return increment
}

func optimizeStep11(registers map[string]int) int {
    for registers["b"] % registers["d"] != 0 {
        registers["d"]++
    }

    for registers["b"] == registers["d"] {
        return 30
    }

    return 25
}

func CoprocessorConflagration(instructions []Instruction) int {
    registers := make(map[string]int)
    registers["a"] = 1

    i := 0
    for i < len(instructions) {
        if i == 11 {
           i = optimizeStep11(registers)
        }

        i += executeInstruction(registers, instructions[i])
    }

    return registers["h"]
}

func ReadInput(fileName string) []Instruction {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := []Instruction {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := strings.Split(scanner.Text(), " ")
        name := line[0]
        x := line[1]
        instruction := Instruction {
            name : name,
            x : x,
        }
        if (len(line) > 2) {
            instruction.y = line[2]
        }
        result = append(result, instruction)
    }

    return result
}

func main() {
    input := ReadInput("../input")
    result := CoprocessorConflagration(input)
    fmt.Println(result)
}