package main

import (
    "fmt"
    "strings"
    "io/ioutil"
)

func appendIfMissing(slice []string, value string) []string {
    for _, val := range slice {
        if value == val {
            return slice
        }
    }
    return append(slice, value)
}

func IsValidPassphrase(passphrase string) (bool) {
    words := strings.Split(passphrase," ")
    distinctWords := []string {}

    for _, word := range words {
        distinctWords = appendIfMissing(distinctWords, word)
    }

    return len(words) == len(distinctWords)
}

func HighEntropyPassphrases(fileName string) int {
    dat, _ := ioutil.ReadFile(fileName)
    passphrases := strings.Split(string(dat),"\n")

    result := 0
    for _, passphrase := range passphrases {
        if (IsValidPassphrase(passphrase)) {
            result++
        }
    }
    return result
}

func main() {
    result := HighEntropyPassphrases("../input")
    fmt.Println(result)
}