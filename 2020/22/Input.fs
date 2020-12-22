module Input

open System
open System.IO

type input(cards: int list) =
    member this.cards = cards

let read = seq {
    let lines = File.ReadAllLines("..\..\..\input")

    let mutable i = 1
    let mutable cards = []
    while i < lines.Length do
        if lines.[i] = "" then
            yield input(cards)
            i <- i + 2
            cards <- []
        cards <- cards @ [Int32.Parse(lines.[i])]
        i <- i + 1
    yield input(cards)
}