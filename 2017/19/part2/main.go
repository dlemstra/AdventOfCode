package main

import (
    "fmt"
    "os"
    "bufio"
)

func findStart(row []rune) int {
    for i,c := range row {
        if c != ' ' {
            return i
        }
    }

    panic("should not be reached")
}

func SeriesOfTubes(maze [][]rune) int {
    x := findStart(maze[0])
    y := 0
    ver := 1
    hor := 0
    steps := 0
    for true {
        c := maze[y][x]
        switch(c) {
            case '+':
                if ver != 0 {
                    if x == 0 || maze[y][x - 1]  == ' ' {
                        hor = 1
                    } else {
                        hor = -1
                    }
                    ver = 0
                } else {
                    if y == len(maze) - 1 || maze[y + 1][x]  == ' ' {
                        ver = -1
                    } else {
                        ver = 1
                    }
                    hor = 0
                }
            case ' ':
                return steps
        }
        steps++
        y += ver
        x += hor

        if y == -1 || y == len(maze) || x == -1 || x == len(maze[y])  {
            return steps
        }
    }

    return steps
}

func ReadInput(fileName string) [][]rune {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := [][]rune {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        row := []rune {}
        for _,c := range scanner.Text() {
            row = append(row, c)
        }
        result = append(result, row)
    }

    return result
}

func main() {
    input := ReadInput("../input")
    result := SeriesOfTubes(input)
    fmt.Println(result)
}