module Part2
open Input

let toInteger(value: char[], bitOne: char, start: int, stop: int) =
    let mutable result = 0
    for i in start .. stop do
        if (value.[i] = bitOne) then
            result <- result ||| (1 <<< stop - i)
    result

let getSeatId(input: input) =
    let row = toInteger(input.data, 'B', 0, 6)
    let column = toInteger(input.data, 'R', 7, 9)
    row * 8 + column

let findSeat(inputs: seq<input>) = seq {
    let seatIds = inputs |> Seq.map getSeatId |> Seq.sort

    let mutable prev = 0
    for seatId in seatIds do
        if seatId - prev <> 1 && prev <> 0 then
            yield prev + 1
        else
            prev <- seatId
}

let execute(inputs: seq<input>) =
    Seq.item 0 (findSeat inputs)