module Input

open System
open System.IO

type range(min: int, max: int) =
    member this.min = min
    member this.max = max

type restriction(name: string, first: range, second: range) =
    member this.name = name
    member this.first = first
    member this.second = second

type ticket(numbers: list<int>) =
    member this.numbers = numbers

type input(restrictions: list<restriction>, ticket: ticket, nearByTickets: list<ticket>) =
    member this.restrictions = restrictions
    member this.ticket = ticket
    member this.nearByTickets = nearByTickets

let createRange(value: string) = 
    let info = value.Split('-')
    range(Int32.Parse info.[0], Int32.Parse info.[1])

let createTicket(value: string) =
    let numbers = value.Split(',') |> Seq.map Int32.Parse |> List.ofSeq
    ticket(numbers)

let read =
    let lines = File.ReadAllLines("..\..\..\input")

    let mutable restrictions = []

    let mutable index = 0
    while lines.[index] <> "" do
        let info = lines.[index].Split(":")
        let name = info.[0]
        let ranges = info.[1].Trim().Split(' ')
        let first = createRange ranges.[0]
        let second = createRange ranges.[2]
        restrictions <- restrictions @ [restriction(name, first, second)]
        index <- index + 1

    let myTicket = createTicket lines.[index + 2]

    let mutable nearByTickets = []

    index <- index + 5
    while index < lines.Length do
        let ticket = createTicket lines.[index]
        nearByTickets <- nearByTickets @ [ticket]
        index <- index + 1

    input(restrictions, myTicket, nearByTickets)