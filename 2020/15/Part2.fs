module Part2

open Input
open System.Collections.Generic

type spoken(number: int) =
    let mutable prev = number
    let mutable last = number
    member this.age = last - prev
    member this.updateLast(turn: int) =
        prev <- last
        last <- turn

let execute(input: input) =
    let numbers = new Dictionary<int, spoken>()
    let mutable turn = 1

    let mutable last = -1
    for number in input.numbers do
        last <- number
        numbers.[last] <- spoken(turn)
        turn <- turn + 1

    while turn <= 30000000 do
        last <- numbers.[last].age

        if numbers.ContainsKey(last) then
            numbers.[last].updateLast turn
        else
            numbers.[last] <- spoken(turn)

        turn <- turn + 1

    last
