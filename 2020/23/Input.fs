module Input

open System
open System.IO

type input(numbers: int list) =
    member this.numbers = numbers

let read =
    let lines = File.ReadAllLines("..\..\..\input")
    input(lines.[0] |> Seq.map (fun c -> Int32.Parse(c.ToString())) |> Seq.toList)