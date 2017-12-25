package main

import (
    "fmt"
    "os"
    "bufio"
    "strings"
    "strconv"
)

type Tower struct {
    name string
    weight int
    childNames []string
    children []*Tower
    parent *Tower
    total int
}

func contains(items []string, item string) bool {
    for _, a := range items {
        if a == item {
            return true
        }
    }
    return false
}

func getPointers(towers []Tower) []*Tower {
    result := make([]*Tower, len(towers))
    for i,_ := range towers {
        result[i] = &towers[i]
    }

    return result;
}

func buildTree(tower *Tower, towers []*Tower) {
    for _,elem := range towers {
        if contains(elem.childNames, tower.name) {
            tower.parent = elem
            elem.children = append(elem.children, tower)
            return
        }
    }
}

func getRoot(towers []*Tower) *Tower{
    for _,tower := range towers {
        buildTree(tower, towers)
    }

    for _,tower := range towers {
        if tower.parent == nil {
            return tower
        }
    }

    panic("should not be reached")
}

func getTotal(tower *Tower) int {
    total := tower.weight

    for _, child := range tower.children {
       total += getTotal(child)
    }

    return total
}

func min(towers []*Tower) int {
    min := towers[0].total
    for _,tower := range towers[1:] {
        if tower.total < min {
            min = tower.total
        }
    }

    return min
}

func max(towers []*Tower) (int, *Tower) {
    max := towers[0].total
    maxTower := towers[0]
    for _,tower := range towers[1:] {
        if tower.total > max {
            max = tower.total
            maxTower = tower
        }
    }

    return max, maxTower
}

func findUnbalanced(tower *Tower, towers []*Tower) int {
    min := min(tower.children)
    max, maxTower := max(tower.children)
    if (max != min) {
        val := findUnbalanced(maxTower, towers)
        if val == 0 {
            return maxTower.weight - (max - min)
        }

        return val
    }

    return 0;
}

func RecursiveCircus(input []Tower) int {
    towers := getPointers(input)
    root := getRoot(towers)

    for i,_ := range towers {
        towers[i].total = getTotal(towers[i])
    }

    return findUnbalanced(root, towers)
}

func ReadInput(fileName string) []Tower {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := []Tower {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := strings.Split(scanner.Text(), " -> ")
        start := strings.Split(line[0], " ")

        name := start[0]
        weight,_ := strconv.Atoi(start[1][1:len(start[1])-1])
        childNames := []string {}
        if (len(line) > 1) {
            childNames = strings.Split(line[1], ", ")
        }
        tower := Tower {
            name: name,
            weight: weight,
            childNames: childNames,
        }
        result = append(result, tower)
    }

    return result
}

func main() {
    input := ReadInput("../input")
    result := RecursiveCircus(input)
    fmt.Println(result)
}