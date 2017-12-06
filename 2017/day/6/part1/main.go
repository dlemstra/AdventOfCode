package main

import (
    "fmt"
    "strconv"
    "strings"
    "io/ioutil"
)

func MemoryReallocation(input []int) int {
    return len(input)
}

func ReadInput(fileName string) []int {
    dat, _ := ioutil.ReadFile(fileName)
    items := strings.Split(string(dat),"\t")
    result := make([]int,len(items))
    for i, _ := range items {
        value, _ := strconv.Atoi(items[i])
        result[i] = value
    }
    return result
}

func main() {
    input := ReadInput("../input")
    result := MemoryReallocation(input)
    fmt.Println(result)
}