package main

import (
    "fmt"
    "io/ioutil"
    "strings"
    "strconv"
)

func KnotHash(input string) string {
    return input
}

func ReadInput(fileName string) []int {
    dat, _ := ioutil.ReadFile(fileName)
    items := strings.Split(string(dat),",")
    result := make([]int, len(items))
    for i, _ := range items {
        value, _ := strconv.Atoi(items[i])
        result[i] = value
    }
    return result
}

func CreateString(input []int) string {
    return "string"
}

func main() {
    input := ReadInput("../input")
    str := CreateString(input)
    result := KnotHash(str)
    fmt.Println(result)
}