module Part1
open Input

let toInteger(value: char[], bitOne: char, start: int, stop: int) =
    let mutable result = 0
    for i in start .. stop do
        if (value.[i] = bitOne) then
            result <- result ||| (1 <<< stop-i)
    result

let getSeatId(input: input) =
    let row = toInteger(input.data, 'B', 0, 6)
    let column = toInteger(input.data, 'R', 7, 9)
    row * 8 + column

let execute(inputs: seq<input>) =
    inputs
        |> Seq.map getSeatId
        |> Seq.max
