package main

import (
    "fmt"
)

func insert(items []int, index int, value int) []int {
    newItem := []int { value }
    return append(items[:index], append(newItem, items[index:]...)...)
}

func Spinlock(input int) int {
    items := []int { 0 }

    index := 0
    for i:=1; i < 2018; i++ {
        index = (index + input) % len(items) + 1
        items = insert(items, index, i)
    }

    for i,_ := range items {
        if items[i] == 2017 {
            return  items[i + 1 % len(items)]
        }
    }

    panic("should not be reached")
}

func main() {
    result := Spinlock(386)
    fmt.Println(result)
}