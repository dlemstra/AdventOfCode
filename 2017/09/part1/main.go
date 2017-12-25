package main

import (
    "fmt"
    "io/ioutil"
)

func StreamProcessing(input string) int {
    score := 0
    level := 0
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
                    continue
                }
                switch c {
                    case '<':
                        insideGarbage = true
                    case '{':
                        level++
                    case '}':
                        score += level
                        level--
                }
        }
    }
    return score
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