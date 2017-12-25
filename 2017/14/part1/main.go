package main

import (
    "fmt"
    "strconv"
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

func createList(length int) []byte {
    list := make([]byte, length)
    for i,_ := range list {
        list[i] = byte(i)
    }

    return list
}

func createHash(input []byte) []byte {
    list := createList(256)
    bytes := calculateHash(list, input)

    denseHash := make([]byte, 16)
    for i,_ := range denseHash {
        offset := i * 16
        value := bytes[offset]
        for j:=1; j < 16; j++ {
            value ^= bytes[offset + j]
        }

        denseHash[i] = value
    }

    return denseHash
}

func hashCount(input string, index int) int {
    bytes := []byte(input + "-" + strconv.Itoa(index))
    bytes = append(bytes, []byte {17, 31, 73, 47, 23}...)

    hash := createHash(bytes)

    count := 0
    for _,x := range hash {
        i := byte(128)
        for i > 0 {
            if x & i != 0 {
                count++
            }
            i = i / 2
        }
    }
    return count
}

func DiskDefragmentation(input string) int {
    count := 0
    for i:=0; i < 128; i++ {
        count += hashCount(input,i)
    }
    return count
}

func main() {
    result := DiskDefragmentation("nbysizxe")
    fmt.Println(result)
}