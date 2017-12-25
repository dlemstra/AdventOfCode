package main

import (
    "fmt"
    "os"
    "bufio"
    "strings"
)

type Rule struct
{
    inputLength int
    inputs [][]rune

    outputLength int
    output []rune
}

func formatArray(input []rune, length int) string {
    buffer := []rune {}
    for i,c := range input {
        if i > 0 && i % length == 0 {
            buffer = append(buffer, '\n')
        }
        buffer = append(buffer, c)
    }
    buffer = append(buffer, '\n')
    return string(buffer)
}

func (p Rule) matches(other []rune) bool {
    for _,input := range p.inputs {
        found := true
        for i,_ := range other {
            if input[i] != other[i] {
                found = false
            }
        }
        if found {
            return true
        }
    }
    return false
}

func createArray(input string) ([]rune, int) {
    result := []rune {}
    length := 0
    for i,c := range input {
        if c != '/' {
            result = append(result, c)
        } else if length == 0 {
            length = i
        }
    }
    return result, length
}

func createParts(input []rune, length int, partLength int) ([][]rune, int) {
    result := [][]rune {}
    count := (length / partLength)
    steps := length / count

    i := 0
    for len(result) < count * count {
        part := []rune {}
        for j:=0; j < partLength; j++ {
            offset := i + (j * length)
            for k:=0; k < partLength; k++ {
                part = append(part, input[offset + k])
            }
        }
        result = append(result, part)

        i += steps
        if i % length == 0 {
            i += length * (steps - 1)
        }
    }

    return result, count
}

func combineParts(parts [][]rune, length int, count int) []rune {
    result := []rune {}
    offset := 0
    total := (count * length) * (count * length)
    for len(result) < total {
        for i:=0; i < length; i++ {
            index := i * length
            for j:=0; j < count; j++ {
                part := parts[offset + j]
                for k:=0; k < length; k++ {
                    result = append(result, part[index + k])
                }
            }
        }
        offset += count
    }
    return result
}

func createFractal(data []rune, length int, rules []Rule) ([]rune,int) {
    newLength := 0

    parts, count := createParts(data, length, rules[0].inputLength)
    for i,part := range parts {
        for _,rule := range rules {
            if rule.matches(part) {
                parts[i] = append([]rune{}, rule.output...)
                newLength = rule.outputLength
                break
            }
        }
    }

    result := combineParts(parts, newLength, count)

    return result, newLength * count
}

func findRules(rules []Rule, length int) []Rule {
    result := []Rule {}
    for _,rule := range rules {
        if rule.inputLength == length {
            result = append(result, rule)
        }
    }

    return result
}

func FractalArt(rules []Rule, iterations int) int {

    data,length := createArray(".#./..#/###")

    rules2 := findRules(rules, 2)
    rules3 := findRules(rules, 3)

    for i:=0; i < iterations; i++ {
        if length % 2 == 0 {
            data,length = createFractal(data, length, rules2)
        } else if length % 3 == 0 {
            data,length = createFractal(data, length, rules3)
        } else {
            panic("should not be reached")
        }
    }

    count := 0
    for _,c := range data {
        if c == '#' {
            count++
        }
    }

    return count
}

func flipHorizontal(input []rune, length int) []rune {
    result := []rune{}

    for offset := 0; offset < len(input); offset += length {
        for i:=offset + length - 1; i >= offset; i-- {
            result = append(result, input[i])
        }
    }
    return result
}

func flipVertical(input []rune, length int) []rune {
    result := []rune{}

    for offset := len(input) - length; offset >= 0; offset -= length {
        for i := offset; i < offset + length; i ++ {
            result = append(result, input[i])
        }
    }
    return result
}

func rotate(input []rune, length int) []rune {
    result := []rune{}

    for offset := 0; offset < length; offset++ {
        for i := len(input) - length + offset; i >= 0; i -= length {
            result = append(result, input[i])
        }
    }
    return result
}

func createInputs(input []rune, length int) [][]rune {
    result := [][]rune {}
    result = append(result, input)
    result = append(result, rotate(result[0], length))
    result = append(result, rotate(result[1], length))
    result = append(result, rotate(result[2], length))
    result = append(result, flipHorizontal(input, length))
    result = append(result, flipVertical(input, length))
    result = append(result, flipHorizontal(result[0], length))
    result = append(result, flipVertical(result[0], length))
    result = append(result, flipHorizontal(result[1], length))
    result = append(result, flipVertical(result[1], length))
    result = append(result, flipHorizontal(result[2], length))
    result = append(result, flipVertical(result[2], length))

    return result
}

func ReadInput(fileName string) []Rule {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := []Rule {}
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := strings.Split(scanner.Text(), " => ")
        input, inputLength := createArray(line[0])
        output, outputLength := createArray(line[1])
        rule := Rule {
            inputLength : inputLength,
            inputs : createInputs(input, inputLength),
            outputLength : outputLength,
            output : output,
        }
        result = append(result, rule)
    }

    return result
}

func main() {
    input := ReadInput("../input")
    result := FractalArt(input, 18)
    fmt.Println(result)
}