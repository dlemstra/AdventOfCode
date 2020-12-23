module Part2

open Input
open System.Collections.Generic

let rec findDestination(cups: LinkedListNode<int> seq, destination: int, maxValue: int) =
    if destination = 0 then
        findDestination(cups, maxValue, maxValue)
    else
        let mutable found = false
        for cup in cups do
            if cup.Value = destination then found <- true

        if found then findDestination(cups, destination - 1, maxValue) else destination

let getNext(cup: LinkedListNode<int>) =
    if cup.Next <> null then cup.Next else cup.List.First

let getNextCups(cup: LinkedListNode<int>) = seq {
    let mutable next = getNext(cup)
    for i = 1 to 3 do
        yield next
        next <- getNext(next)
}

let execute(input: input) =
    let maxValue = 1000000
    let mutable cupList = new LinkedList<int>();
    let mutable cups = new Dictionary<int, LinkedListNode<int>>()

    for number in input.numbers do
        cups.[number] <- cupList.AddLast(number)

    let mutable value = (Seq.max input.numbers) + 1

    while value <= maxValue do
        cups.[value] <- cupList.AddLast(value)
        value <- value + 1

    let mutable current = cupList.First

    for _ in 1 .. 10000000 do
        let nextCups = getNextCups(current) |> Seq.toList
        let destination = findDestination(nextCups, current.Value - 1, maxValue)

        let target = cups.[destination]

        for cup in nextCups do
            cupList.Remove(cup)

        for cup in (Seq.rev nextCups) do
            cupList.AddAfter(target, cup)

        current <- getNext(current)

    let next = getNext(cups.[1])
    let first = int64 next.Value
    let second = int64 (getNext(next).Value)
    first * second
