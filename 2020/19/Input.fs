module Input

open System
open System.IO

type input(patterns: list<string>, messages: list<string>) =
    member this.patterns = patterns
    member this.messages = messages

let read =
    let lines = File.ReadAllLines("..\..\..\input")

    let mutable rules = []
    let mutable i = 0
    while lines.[i] <> "" do
        let info = lines.[i].Split(':')
        rules <- rules @ [(Int32.Parse info.[0], info.[1].Trim())]
        i <- i + 1

    let patterns = Seq.sort rules |> Seq.map (fun (_, pattern) -> pattern) |> Seq.toList

    input(patterns, Seq.skip (i + 1) lines |> Seq.toList)
