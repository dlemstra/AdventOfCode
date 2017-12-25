package main

import (
    "fmt"
    "os"
    "bufio"
    "strings"
    "strconv"
)

type Component struct
{
    left int
    right int
}

func buildBridge(components []Component, index int, left bool) ([]int, int) {
    items := append([]Component {}, components...)
    current := items[index]

    strength := current.left + current.right
    result := []int {}
    if (left) {
        result = append(result, current.right)
        result = append(result, current.left)
    } else {
        result = append(result, current.left)
        result = append(result, current.right)
    }

    if len(items) == 2 {
        return result, strength
    }

    remaining := append(items[:index], items[index+1:]...)

    best := []int {}
    bestLength := 0
    bestStrength := 0
    for i,r := range remaining {
        a := []int {}
        b := []int {}
        strengthA := 0
        strengthB := 0

        if left {
            if current.left == r.left {
                a, strengthA = buildBridge(remaining, i, false)
            }
            if current.left == r.right {
                b, strengthB = buildBridge(remaining, i, true)
            }
        } else {
            if current.right == r.left {
                a, strengthA = buildBridge(remaining, i, false)
            }
            if current.right == r.right {
                b, strengthB = buildBridge(remaining, i, true)
            }
        }

        if strengthA > 0 {
            if len(a) > bestLength || (len(a) == bestLength && strengthA > bestStrength) {
                best = a
                bestLength = len(a)
                bestStrength = strengthA
            }
        }

        if strengthB > 0 {
            if len(b) > bestLength || (len(b) == bestLength && strengthB > bestStrength) {
                best = b
                bestLength = len(b)
                bestStrength = strengthB
            }
        }
    }

    if len(best) > 0 {
        result = append(result, best...)
    }

    return result, strength + bestStrength
}

func ElectromagneticMoat(components []Component) int {
    max := 0
    maxStrength := 0

    for i := range components {
        if components[i].left != 0 {
            continue
        }

        bridge, strength := buildBridge(components, i, false)
        if len(bridge) > max || len(bridge) == max && strength > maxStrength {
            max = len(bridge)
            maxStrength = strength
        }
    }

    return maxStrength
}

func ReadInput(fileName string) []Component {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := []Component {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := strings.Split(scanner.Text(), "/")
        left, _ := strconv.Atoi(line[0])
        right, _ := strconv.Atoi(line[1])
        component := Component {
            left : left,
            right : right,
        }
        result = append(result, component)
    }

    return result
}

func main() {
    input := ReadInput("../input")
    result := ElectromagneticMoat(input)
    fmt.Println(result)
}