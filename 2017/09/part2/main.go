package main

import (
    "fmt"
    "io/ioutil"
)

func StreamProcessing(input string) int {
    total := 0
    insideGarbage := false

    for i := 0; i < len(input); i++ {
        c := input[i]
        switch c {
            case '!':
                i++
            case '>':
                insideGarbage = false
            default:
                if insideGarbage == true {
                    total++
                    continue
                }
                if c == '<' {
                    insideGarbage = true
                }
        }
    }
    return total
}

func ReadInput(fileName string) string {
    dat, _ := ioutil.ReadFile(fileName)
    return string(dat)
}

func main() {
    input := ReadInput("../input")
    result := StreamProcessing(input)
    fmt.Println(result)
}