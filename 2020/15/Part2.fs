module Part2

open Input
open System.Collections.Generic

type spoken = { mutable prev: int; mutable last: int }

let execute(input: input) =
    let numbers = new Dictionary<int, spoken>()
    let mutable turn = 1

    let mutable last = -1
    for number in input.numbers do
        last <- number
        numbers.[last] <- { prev = turn; last = turn }
        turn <- turn + 1

    while turn <= 30000000 do
        let spoken = numbers.[last]

        if spoken.prev = spoken.last then
            last <- 0
        else
            last <- spoken.last - spoken.prev

        if numbers.ContainsKey(last) then
            numbers.[last].prev <- numbers.[last].last
            numbers.[last].last <- turn
        else
            numbers.[last] <- { prev = turn; last = turn }

        turn <- turn + 1

    last
