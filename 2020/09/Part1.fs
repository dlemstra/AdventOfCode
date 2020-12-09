module Part1

open Input
open System

let start = 25

let getNumbers(inputs: seq<input>) = seq {
    for input in inputs do
        yield Int64.Parse(input.number)
}

let isValid(numbers: list<int64>, offset: int) =
    let number = numbers.[offset]
    let min =  offset - start
    let max =  offset - 1

    let mutable i = min
    let mutable valid = false
    while valid = false && i < max do
        let difference = abs number - numbers.[i]
        for j = min to max do
            if i <> j && difference = numbers.[j] then
                valid <- true
        i <- i + 1
    valid

let findNumber(numbers: list<int64>) =
    let mutable i = start
    let mutable number = int64 0
    while number = int64 0 do
        let valid = isValid(numbers, i)
        if not valid then
            number <- numbers.[i]
        else
            i <- i + 1
    number

let execute(inputs: seq<input>) =
    let numbers = List.ofSeq (getNumbers inputs)
    findNumber numbers