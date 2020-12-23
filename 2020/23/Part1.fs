module Part1

open Input
open System
open System.Collections.Generic

let rec findDestination(cups: LinkedListNode<int> seq, destination: int, size: int) =
    if destination = 0 then
        findDestination(cups, size, size)
    else
        let mutable found = false
        for cup in cups do
            if cup.Value = destination then found <- true

        if found then findDestination(cups, destination - 1, size) else destination

let getNext(cup: LinkedListNode<int>) =
    if cup.Next <> null then cup.Next else cup.List.First

let getNextCups(cup: LinkedListNode<int>) = seq {
    let mutable next = getNext(cup)
    for i = 1 to 3 do
        yield next
        next <- getNext(next)
}

let execute(input: input) =
    let size = (Seq.length input.numbers)
    let mutable cupList = new LinkedList<int>();
    let mutable indexes = new Dictionary<int, LinkedListNode<int>>()

    let mutable index = 0
    for number in input.numbers do
        indexes.[number] <- cupList.AddLast(number)
        index <- index + 1

    let mutable current = cupList.First

    for _ in 1 .. 100 do
        let nextCups = getNextCups(current) |> Seq.toList
        let destination = findDestination(nextCups, current.Value - 1, size)

        let target = indexes.[destination]

        for cup in nextCups do
            cupList.Remove(cup)

        for cup in (Seq.rev nextCups) do
            cupList.AddAfter(target, cup)

        current <- getNext(current)

    let mutable result = ""

    current <- indexes.[1].Next
    while current <> indexes.[1] do
        result <- result + current.Value.ToString()
        current <- getNext(current)

    Int32.Parse(result)