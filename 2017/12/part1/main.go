package main

import (
    "fmt"
    "os"
    "bufio"
    "strings"
)

func contains(list []string, item string) bool {
    for _,elem := range list {
        if elem == item {
            return true
        }
    }

    return false
}

func findGroupIndex(groups [][]string, names []string) int {
     for _,name := range names {
        for i,_ := range groups {
            if contains(groups[i], name) {
                return i
            }
        }
    }

    return -1
}

func appendUnique(a []string, b []string) []string {
    result := []string {}

    result = append(result, a...)

    for _, bb := range b {
        if !contains(result, bb) {
            result = append(result, bb)
        }
    }

    return result
}

func mergeGroups(input [][]string) [][]string {
    groups := [][]string {}
    
        for _,names := range input {
            groupIndex := findGroupIndex(groups, names)
            if groupIndex == -1 {
                groups = append(groups, []string {})
                groupIndex = len(groups) - 1
            }
    
            groups[groupIndex] = appendUnique(groups[groupIndex], names)
        }

    return groups
}

func getGroupLength(groups [][]string, member string) int {
    for _,group := range groups {
        if contains(group, member) {
            return len(group)
        }
    }

    return -1
}

func DigitalPlumber(input [][]string) int {
    length := 0

    groups := mergeGroups(input)
    for length != len(groups) {
        length = len(groups)
        groups = mergeGroups(groups)
    }

    return getGroupLength(groups, "0")
}

func ReadInput(fileName string) [][]string {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := [][]string {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := strings.Split(scanner.Text(), " <-> ")
        name := line[0]
        connections := strings.Split(line[1], ", ")

        names := append(connections, name)
        result = append(result, names)
    }

    return result
}

func main() {
    input := ReadInput("../input")
    result := DigitalPlumber(input)
    fmt.Println(result)
}