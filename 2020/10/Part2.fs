module Part2

open Input
open System

let getNumbers(inputs: seq<input>) = seq {
    for input in inputs do
        yield Int32.Parse(input.number)
}

let countArrangements(numbers: list<int>) =
    let mutable combinations = Array.zeroCreate<int64> numbers.Length

    for i = 0 to combinations.Length - 1 do
        let number = numbers.[i]
        if number <= 3 then
            combinations.[i] <- 1L

        for j = i - 3 to i - 1 do
            if j >= 0 && number - numbers.[j] <= 3 then
                combinations.[i] <- combinations.[i] + combinations.[j]

    Seq.last combinations

let execute(inputs: seq<input>) =
    let numbers = getNumbers inputs |> Seq.sort |> List.ofSeq

    countArrangements numbers
