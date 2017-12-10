package main

import (
    "fmt"
    "io/ioutil"
    "strings"
    "strconv"
)

func KnotHash(list []int, input []int) int {
    return len(input)
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

func CreateList(length int) []int {
    list := make([]int, length)
    for i,_ := range list {
        list[i] = i
    }

    return list
}

func main() {
    list := CreateList(256)
    input := ReadInput("../input")
    result := KnotHash(list, input)
    fmt.Println(result)
}