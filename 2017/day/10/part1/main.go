package main

import (
    "fmt"
    "io/ioutil"
    "strings"
    "strconv"
)

func getReversedPart(list []int, offset int, length int) []int {
    result := make([]int, length)
    target := length - 1
    for i:=0; i < length; i++ {
        source := (i + offset) % len(list)
        result[target] = list[source]
        target--
    }
    return result
}

func copyPart(list []int, part []int, offset int) {
    index := offset
    for _, item := range part {
        list[index % len(list)] = item
        index++
    }
}

func KnotHash(list []int, input []int) int {
    offset := 0
    skipSize := 0
    for _, length := range input {

        if length > 1 {
            part := getReversedPart(list, offset, length)
            copyPart(list, part, offset)
        }

        offset = (offset + skipSize + length) % len(list)
        skipSize++
    }

    return list[0] * list[1]
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