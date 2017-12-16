package main

import (
    "fmt"
    "io/ioutil"
    "strings"
    "strconv"
)

func spin(group []string, count string) {
    cnt,_ := strconv.Atoi(count)

    for c := 0; c < cnt; c++ {
        prev := group[0]
        for i:=1; i < len(group); i++ {
            value := group[i % len(group)]
            group[i] = prev
            prev = value
        }
        group[0] = prev
    }
}

func exchange(group []string, positions []string) {
     posA,_ := strconv.Atoi(positions[0])
     posB,_ := strconv.Atoi(positions[1])

     group[posA], group[posB] = group[posB], group[posA]
}

func getIndex(group []string, name string) int {
    for i,n := range group {
        if n == name {
            return i
        }
    }

    panic("should not be reached")
}

func partner(group []string, positions []string) {
    posA := getIndex(group, positions[0])
    posB := getIndex(group, positions[1])

    group[posA], group[posB] = group[posB], group[posA]
}

func createGroup(length int) []string {
    result := make([]string, length)
    for i:=0; i < length; i++ {
        result[i] = string(byte(97 + i))
    }
    return result
}

func dance(group []string, actions []string) string {
    for _,action := range actions {
        switch (action[0]) {
            case 's':
                spin(group, action[1:])
            case 'x':
                exchange(group, strings.Split(action[1:], "/"))
            case 'p':
                partner(group, strings.Split(action[1:], "/"))
        }
    }

    return strings.Join(group, "")
}

func PermutationPromenade(actions []string, groupLength int) string {
    group := createGroup(groupLength)

    return dance(group, actions)
}

func ReadInput(fileName string) []string {
    dat, _ := ioutil.ReadFile(fileName)
    return strings.Split(strings.TrimSpace(string(dat)), ",")
}

func main() {
    input := ReadInput("../input")
    result := PermutationPromenade(input, 16)
    fmt.Println(result)
}