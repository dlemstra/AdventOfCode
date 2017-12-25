package main

import (
    "fmt"
    "os"
    "bufio"
)

type State struct
{
    name string

    zeroValue int
    zeroStep int
    zeroNext int

    oneValue int
    oneStep int
    oneNext int
}

type TuringMachine struct
{
    index int
    steps int

    pos int
    ones map[int]int

    states []State
}

func (machine *TuringMachine) WriteValue(value int) {
    if value == 1 {
        if machine.ones[machine.pos] == 0 {
            machine.ones[machine.pos] = 1
        }
    } else {
        if machine.ones[machine.pos] == 1 {
            delete(machine.ones, machine.pos)
        }
    }
}

func (machine *TuringMachine) Run() int {
    total := float32(machine.steps)
    percentage := -1
    for machine.steps > 0 {
        state := machine.states[machine.index]

        if machine.ones[machine.pos] == 0 {
            machine.WriteValue(state.zeroValue)
            machine.pos += state.zeroStep
            machine.index = state.zeroNext
        } else {
            machine.WriteValue(state.oneValue)
            machine.pos += state.oneStep
            machine.index = state.oneNext
        }

        machine.steps--
        newPercentage := int(((total - float32(machine.steps)) / total) * 100)
        if percentage != newPercentage {
            percentage = newPercentage
            fmt.Printf("\r%d%%", percentage)
        }
    }
    fmt.Println()

    return len(machine.ones)
}

func HaltingProblem(machine TuringMachine) int {
    return machine.Run()
}

func readStateValue(scanner *bufio.Scanner) (int, int, int) {
    var number int
    scanner.Scan()
    fmt.Sscanf(scanner.Text(), "    - Write the value %d.", &number)

    step := 1
    scanner.Scan()
    if scanner.Text() == "    - Move one slot to the left." {
        step = -1
    }

    var next rune
    scanner.Scan()
    fmt.Sscanf(scanner.Text(), "    - Continue with state %c.", &next)

    return number, step, int(next) - 65
}

func ReadInput(fileName string) TuringMachine {
    file, _ := os.Open(fileName)
    defer file.Close()

    result := TuringMachine {}
    result.ones = make(map[int]int)

    scanner := bufio.NewScanner(file)

    var char rune
    scanner.Scan()
    fmt.Sscanf(scanner.Text(), "Begin in state %c.", &char)
    result.index = int(char) - 65

    var steps int
    scanner.Scan()
    fmt.Sscanf(scanner.Text(), "Perform a diagnostic checksum after %d steps.", &steps)
    result.steps = steps

    for scanner.Scan() {
        state := State {}

        scanner.Scan()
        fmt.Sscanf(scanner.Text(), "In state %c:", &char)
        state.name = string(char)

        scanner.Scan() // If the current value is 0:
        state.zeroValue, state.zeroStep, state.zeroNext = readStateValue(scanner)

        scanner.Scan() // If the current value is 1:
        state.oneValue, state.oneStep, state.oneNext = readStateValue(scanner)

        result.states = append(result.states, state)
    }

    return result
}

func main() {
    input := ReadInput("input")
    result := HaltingProblem(input)
    fmt.Println(result)
}