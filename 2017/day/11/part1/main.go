package main

import (
    "fmt"
    "io/ioutil"
    "strings"
)

func abs(a int) int {
    if a < 0 {
        return a * -1
    }

    return a
}

func max(a int, b int) int {
    if a > b {
        return a
    }

    return b
}

func HexEd(input []string) int {
    x := 0
    y := 0
    z := 0

    for _, str := range input {
        switch str {
            case "n":
                y++
                z--
            case "ne":
                x++
                z--
            case "se":
                x++
                y--
            case "s":
                z++
                y--
            case "sw":
                z++
                x--
            case "nw":
                y++
                x--
        }
    }

    return max(abs(x), max(abs(y), abs(z)))
}

func ReadInput(fileName string) []string {
    dat, _ := ioutil.ReadFile(fileName)
    return strings.Split(strings.TrimSpace(string(dat)),",")
}

func main() {
    input := ReadInput("../input")
    result := HexEd(input)
    fmt.Println(result)
}