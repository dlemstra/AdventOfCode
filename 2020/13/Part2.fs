module Part2

open Input

let execute(input: input) =
    let busses =
        input.busses
        |> Seq.skip 1
        |> Seq.sortBy (fun bus -> bus.id)
        |> List.ofSeq

    let mutable step = (Seq.item 0 input.busses).id
    let mutable timestamp = 0L

    let mutable i = 0
    while i < busses.Length do
        timestamp <- timestamp + step
        if (timestamp + busses.[i].offset) % busses.[i].id = 0L then
            step <- step * busses.[i].id
            i <- i + 1

    timestamp
