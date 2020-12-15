module Input

open System
open System.IO

type input(numbers: seq<int>) =
    member this.numbers = numbers

let read =
    let lines = File.ReadAllLines("..\..\..\input")

    let numbers = lines.[0].Split(',') |> Seq.map Int32.Parse
    input(numbers)