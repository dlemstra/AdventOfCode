package main

import (
    "fmt"
    "os"
    "bufio"
)

const (
    North = 0
    East = 1
    South = 2
    West = 3
)

type Pos struct
{
    x int
    y int
}

func (pos *Pos) Left(direction int) int {
    switch(direction) {
        case North:
            pos.x--
            return West
        case West:
            pos.y++
            return South
        case South:
            pos.x++
            return East
        case East:
            pos.y--
            return North
    }

    panic("should never be reached")
}

func (pos *Pos) Right(direction int) int {
    switch(direction) {
        case North:
            pos.x++
            return East
        case East:
            pos.y++
            return South
        case South:
            pos.x--
            return West
        case West:
            pos.y--
            return North
    }

    panic("should never be reached")
}

func findInfected(input []string) map[Pos]bool {
    result := make(map[Pos]bool)
    center := (len(input) - 1) / 2
    pos := Pos { x : -center, y : -center }

    start := pos.x
    for _,line := range input {
        for _,char := range line {
            if char == '#' {
                result[pos] = true
            }
            pos.x++
        }
        pos.y++
        pos.x = start
    }

    return result
}

func SporificaVirus(input []string, iterations int) int {
    infected := findInfected(input)

    count := 0
    pos := Pos { x : 0, y : 0 }
    direction := North
    for i := 0; i < iterations; i++ {
        if infected[pos] {
            delete(infected, pos)
            direction = pos.Right(direction)
        } else {
            count++
            infected[pos] = true
            direction = pos.Left(direction)
        }
    }

    return count
}

func ReadInput(fileName string) []string {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := []string {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        result = append(result, scanner.Text())
    }

    return result
}

func main() {
    input := ReadInput("../input")
    result := SporificaVirus(input, 10000)
    fmt.Println(result)
}