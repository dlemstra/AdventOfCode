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

func checkSeen(seen [][]int, values []int) ([][]int, int) {
    for j, elem := range seen {
        for i:=0; i < len(values); i++ {
            if values[i] != elem[i] {
                break
            }
            if i == len(values) - 1 {
                return seen, len(seen) - j
            }
        }
    }

    seen = append(seen, copyArray(values))
    return seen, 0
}

func getIndexes(offset int, count int, length int) chan int {
    c := make(chan int, count)
    for count > 0 {
        c <- offset % length
        offset++
        count--
    }
    close(c)

    return c
}

func MemoryReallocation(input []int) int {
    cycles := 0
    seen := [][]int {}

    for cycles == 0 {
        index, max := max(input)
        input[index] -= max

        for i := range getIndexes(index + 1, max, len(input)) {
            input[i]++
        }
        seen, cycles = checkSeen(seen, input)
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