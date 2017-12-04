package main

import (
    "fmt"
    "strings"
    "io/ioutil"
)

func IsValidPassphrase(passphrase string) (bool) {
    return false
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