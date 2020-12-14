module Input

open System.IO
open System

type bus(id: int64, offset: int64) =
    member this.id = id
    member this.offset = offset

type input(timestamp: int64, busses: seq<bus>) =
    member this.timestamp = timestamp
    member this.busses = busses

let readBusses(line: string) = seq<bus> {
    let ids = line.Split(',')
    for i = 0 to ids.Length - 1 do
        let id = ids.[i]
        if id <> "x" then
            yield bus(Int64.Parse id, int64 i)

}

let read =
    let lines = File.ReadAllLines("..\..\..\input")

    let timestamp = Int64.Parse lines.[0]
    let busses = readBusses lines.[1]

    input(timestamp, busses)