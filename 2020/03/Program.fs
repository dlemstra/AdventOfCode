open System.IO
open Input

let readInput =
    let lines = File.ReadAllLines("..\..\..\input")
    lines |>  Seq.map input

[<EntryPoint>]
let main argv =
    let inputs = readInput

    printfn "%d" (Part1.execute inputs)
    printfn "%d" (Part2.execute inputs)
    0
