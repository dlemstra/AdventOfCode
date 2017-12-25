package main

import (
    "fmt"
    "strconv"
    "strings"
    "io/ioutil"
)

func copyArray(input []int) []int {
    clone := make([]int, len(input))
    copy(clone, input)
    return clone
}

func max(input []int) (int, int) {
    index := 0
    max := 0
    for i, val := range input {
        if val > max {
            index = i
            max = val
        }
    }

    return index, max
}

func checkSeen(seen [][]int, values []int) ([][]int, bool) {
    for _, elem := range seen {
        for i:=0; i < len(values); i++ {
            if values[i] != elem[i] {
                break
            }
            if i == len(values) - 1 {
                return seen, true
            }
        }
    }

    seen = append(seen, copyArray(values))
    return seen, false
}

func MemoryReallocation(input []int) int {
    cycles := 0
    seen := [][]int {}
    isSeen := false

    for !isSeen {
        index, max := max(input)
        input[index] -= max
        for i:=0; i < max; i++ {
            index++
            if index == len(input) {
                index = 0
            }
            input[index]++
        }
        seen, isSeen = checkSeen(seen, input)
        cycles++
    }

    return cycles
}

func ReadInput(fileName string) []int {
    dat, _ := ioutil.ReadFile(fileName)
    items := strings.Split(string(dat),"\t")
    result := make([]int, len(items))
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