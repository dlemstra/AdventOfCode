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
    parent *Tower
}

func contains(items []string, item string) bool {
    for _, a := range items {
        if a == item {
            return true
        }
    }
    return false
}

func setParent(tower *Tower, towers []Tower) {
    for _,elem := range towers {
        if contains(elem.childNames, tower.name) {
            tower.parent = &elem
            return
        }
    }
}

func RecursiveCircus(towers []Tower) int {
    for i,_ := range towers {
        setParent(&towers[i], towers)
    }

    for _,tower := range towers {
        if tower.parent == nil {
            return tower.name
        }
    }

   return 0
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