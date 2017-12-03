package main

import (
    "fmt"
)

func size(radius int) int {
    return 1 + radius * 2
}

func maxIndex(radius int) int {
    return size(radius) * size(radius)
}

func createIndexes(radius int) ([][]int, int) {
    size := size(radius)
    indexes := make([][]int, size)
    for i := range indexes {
        indexes[i] = make([]int, size)
    }

    index := maxIndex(radius)
    x := radius
    y := radius
    indexes[x][y] = 0
    start := 0
    end := size

    for r := 0; r < radius; r++ {
        // bottom
        y = end - 1
        for x=end - 1; x >= start; x-- {
            index--
            indexes[y][x] = index
        }

        // left
        x = start
        for y=end - 2; y > start; y-- {
            index--
            indexes[y][x] = index
        }

        // top
        y = start
        for x=start; x < end; x++ {
            index--
            indexes[y][x] = index
        }

        // right
        x = end - 1
        for y=start + 1; y < end - 1; y++ {
            index--
            indexes[y][x] = index
        }

        start++
        end--
    }

    return indexes, maxIndex(radius - 1)
}

func findPos(indexes [][]int, index int) (int, int) {
    for y:=0; y < len(indexes); y++ {
        for x:=0; x < len(indexes); x++ {
            if indexes[y][x] == index {
                return x, y
            }
        }
    }

    panic("should not be reached")
}

func SpiralMemory(input int) int {
    values := []int { 1, 1 }

    radius := 2
    indexes, max := createIndexes(radius)

    for i:=2; i < 1000; i++ {
        if i+1 == max {
            radius++
            indexes, max = createIndexes(radius)
        }

        x, y := findPos(indexes, i)
        value := 0
        for yy:=y-1; yy <= y + 1; yy++ {
            for xx:=x-1; xx <= x + 1; xx++ {
                index := indexes[yy][xx]
                if (index < len(values)) {
                    value += values[index]
                }
            }
        }

        if (value > input) {
            return value
        }

        values = append(values, value)
    }

    panic("not found increment i")
}

func main() {
    result := SpiralMemory(325489)
    fmt.Println(result)
}
