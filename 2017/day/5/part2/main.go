package main

import (
    "fmt"
    "os"
    "bufio"
    "strconv"
)

func changeJump(value int) int {
    if value >= 3 {
        return value - 1
    } else {
        return value + 1
    }
}

func GetTwistyTrampolines(input []int) int {
    steps := 0
    i := 0
    for i < len(input) {
        steps++
        inc := input[i]
        if inc == 0 {
            input[i]++
            continue
        }
        input[i] = changeJump(input[i])
        i += inc
    }
    return steps
}

func TwistyTrampolines(fileName string) int {
    file, _ := os.Open(fileName)
    defer file.Close()

    input := []int {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        val, _ := strconv.Atoi(scanner.Text())
        input = append(input, val)
    }

    return GetTwistyTrampolines(input)
}

func main() {
    result := TwistyTrampolines("../input")
    fmt.Println(result)
}