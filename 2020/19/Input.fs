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

    let maxIndex = rules |> Seq.map (fun (index, _) -> index) |> Seq.max

    let mutable patterns = Array.zeroCreate<string> (maxIndex + 1)
    for index, pattern in rules do
        patterns.[index] <- pattern

    input(patterns |> Seq.toList, Seq.skip (i + 1) lines |> Seq.toList)
