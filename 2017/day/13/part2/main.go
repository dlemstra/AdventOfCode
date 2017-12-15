package main

import (
    "fmt"
    "os"
    "bufio"
    "strings"
    "strconv"
)

type Layer struct {
    index int
    zeroIndex int
}

func isDetected(layers []Layer, delay int) bool {
    for _,layer := range layers {
        if (layer.index + delay) % layer.zeroIndex == 0 {
            return true
        }
    }

    return false
}

func PacketScanners(layers []Layer) int {
    delay := 1
    for isDetected(layers, delay) == true {
       delay++
    }

    return delay
}

func ReadInput(fileName string) []Layer {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := []Layer {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := strings.Split(scanner.Text(), ": ")
        index, _ := strconv.Atoi(line[0])
        value, _ := strconv.Atoi(line[1])
        layer := Layer {
            index : index,
            zeroIndex : value + value - 2,
        }
        result = append(result, layer)
    }

    return result
}

func main() {
    input := ReadInput("../input")
    result := PacketScanners(input)
    fmt.Println(result)
}