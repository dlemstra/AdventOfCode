package main

import (
    "fmt"
    "os"
    "bufio"
    "strings"
    "strconv"
)

func PacketScanners(list map[int]int) int {
    severity := 0
    for key,value := range list {
        zeroIndex := value + value - 2
        if (key % zeroIndex) == 0 {
            severity += key * value
        }
    }
    return severity
}

func ReadInput(fileName string) map[int]int {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := map[int]int {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := strings.Split(scanner.Text(), ": ")
        key, _ := strconv.Atoi(line[0])
        value, _ := strconv.Atoi(line[1])
        result[key] = value
    }

    return result
}

func main() {
    input := ReadInput("../input")
    result := PacketScanners(input)
    fmt.Println(result)
}