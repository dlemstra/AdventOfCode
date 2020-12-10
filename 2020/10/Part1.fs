module Part1

open Input
open System

let getNumbers(inputs: seq<input>) = seq {
    for input in inputs do
        yield Int32.Parse(input.number)
}

let countJolts(numbers: list<int>) =
    let mutable one = 1
    let mutable three = 1
    for i = 1 to numbers.Length - 1 do
        let difference = numbers.[i] - numbers.[i - 1]
        if difference = 1 then
            one <- one + 1
        elif difference = 3 then
            three <- three + 1
        else
            failwithf "Unknown difference"
    one * three

let execute(inputs: seq<input>) =
    let numbers = getNumbers inputs |> Seq.sort |> List.ofSeq

    countJolts numbers
