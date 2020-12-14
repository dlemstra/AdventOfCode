module Part1

open Input

let execute(input: input) =
    let (id, duration) =
        input.busses 
        |> Seq.map (fun bus -> bus.id, bus.id - (input.timestamp % bus.id))
        |> Seq.sortBy snd
        |> Seq.item 0

    id * duration