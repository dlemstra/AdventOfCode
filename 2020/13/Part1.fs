module Part1

open Input
open System

let execute(input: input) =
    let mutable min = Int32.MaxValue
    let mutable bestId = 0

    for id in input.ids do
        let duration =  id - (input.timestamp % id)
        if duration < min then
            min <- duration
            bestId <- id
    bestId * min
