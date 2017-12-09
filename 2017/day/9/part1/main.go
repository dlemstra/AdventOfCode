package main

import (
    "fmt"
    "io/ioutil"
)

func StreamProcessing(input string) int {
    score := 0
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