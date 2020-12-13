module Input

open System.IO
open System

type input(timestamp: int, ids: seq<int>) =
    member this.timestamp = timestamp
    member this.ids = ids

let read =
    let lines = File.ReadAllLines("..\..\..\input")

    let timestamp = Int32.Parse lines.[0]
    let ids = lines.[1].Split(',') |> Seq.filter(fun x -> x <> "x") |> Seq.map Int32.Parse
    input(timestamp, ids)