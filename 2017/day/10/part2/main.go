package main

import (
    "fmt"
    "io/ioutil"
    "encoding/hex"
)

func getReversedPart(list []byte, offset int, length int) []byte {
    result := make([]byte, length)
    target := length - 1
    for i:=0; i < length; i++ {
        source := (i + offset) % len(list)
        result[target] = list[source]
        target--
    }
    return result
}

func copyPart(list []byte, part []byte, offset int) {
    index := offset
    for _, item := range part {
        list[index % len(list)] = item
        index++
    }
}

func calculateHash(list []byte, input []byte) []byte {
    offset := 0
    skipSize := 0

    for i:=0; i < 64; i++ {
        for _, l := range input {
            length := int(l)
            if length > 1 {
                part := getReversedPart(list, offset, length)
                copyPart(list, part, offset)
            }

            offset = (offset + skipSize + length) % len(list)
            skipSize++
        }
    }

    return list
}

func createHash(list []byte, input []byte) string {
    denseHash := make([]byte,16)
    bytes := calculateHash(list, input)

    for i,_ := range denseHash {
        offset := i * 16
        value := bytes[offset]
        for j:=1; j < 16; j++ {
            value ^= bytes[offset + j]
        }

        denseHash[i] = value
    }

    return hex.EncodeToString(denseHash)
}

func createList(length int) []byte {
    list := make([]byte, length)
    for i,_ := range list {
        list[i] = byte(i)
    }

    return list
}

func KnotHash(input string) string {
    list := createList(256)
    bytes := []byte(input)
    bytes = append(bytes, []byte {17, 31, 73, 47, 23}...)
    return createHash(list, bytes)
}

func ReadInput(fileName string) string {
    dat, _ := ioutil.ReadFile(fileName)
    return string(dat)
}

func main() {
    input := ReadInput("../input")
    result := KnotHash(input)
    fmt.Println(result)
}