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
    register string
    value int
    other string
}

func Duet(instructions []Instruction) int {
    registers := make(map[string]int)

    lastSound := 0
    for i:=0; i < len(instructions); i++ {
        instruction := instructions[i]

        name := instruction.register
        value := instruction.value
        if value == 0 {
            value = registers[instruction.other]
        }

        switch (instruction.name) {
            case "snd":
                lastSound = registers[name]
            case "set":
                registers[name] = value
            case "add":
                registers[name] += value
            case "mul":
                registers[name] *= value
            case "mod":
                registers[name] = registers[name] % value
            case "rcv":
                if registers[name] != 0 && lastSound > 0 {
                    return lastSound
                }
            case "jgz":
                if registers[name] > 0 {
                    i += value - 1
                    continue
                }
        }
    }

    panic("should not be reached")
}

func ReadInput(fileName string) []Instruction {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := []Instruction {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := strings.Split(scanner.Text(), " ")
        name := line[0]
        register := line[1]
        instruction := Instruction {
            name : name,
            register : register,
        }
        if (len(line) > 2) {
            val, err := strconv.Atoi(line[2])
            if err == nil {
                instruction.value = val
            } else {
                instruction.other = line[2]
            }
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