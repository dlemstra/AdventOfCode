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

func createRegisters(programId int) map[string]int {
    registers := make(map[string]int)
    registers["p"] = programId
    return registers
}

func getValue(registers map[string]int, value string) int {
    val, err := strconv.Atoi(value)
    if err == nil {
        return val
    }

    return registers[value]
}

func dualDuet(instruction Instruction, registers map[string]int, send *[]int, received *[]int) int {

     increment := 1

     switch (instruction.name) {
        case "snd":
            *send = append(*send, getValue(registers, instruction.x))
        case "set":
            registers[instruction.x] = getValue(registers, instruction.y)
        case "add":
            registers[instruction.x] = getValue(registers, instruction.y) + getValue(registers, instruction.x)
        case "mul":
            registers[instruction.x] = getValue(registers, instruction.y) * getValue(registers, instruction.x)
        case "mod":
            registers[instruction.x] = getValue(registers, instruction.x) % getValue(registers, instruction.y)
        case "rcv":
            if len(*received) == 0 {
                increment = 0
            } else {
                registers[instruction.x] = (*received)[0]
                *received = (*received)[1:]
            }
        case "jgz":
            if getValue(registers, instruction.x) > 0 {
                increment = getValue(registers, instruction.y)
            }
     }

     return increment
}

func Duet(instructions []Instruction) int {
    registers0 := createRegisters(0)
    registers1 := createRegisters(1)

    buffer0 := []int {}
    buffer1 := []int {}

    count := 0

    index0 := 0
    index1 := 0
    for (index0 + index1) < (len(instructions) * 2) {
        increment0 := dualDuet(instructions[index0], registers0, &buffer0, &buffer1)
        increment1 := dualDuet(instructions[index1], registers1, &buffer1, &buffer0)
        
        if increment0 == 0 && increment1 == 0 {
            return count
        }

        if instructions[index1].name == "snd" {
            count++
        }

        index0 += increment0
        index1 += increment1
    }

    return count
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
    result := Duet(input)
    fmt.Println(result)
}