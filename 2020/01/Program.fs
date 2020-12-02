open System
open System.IO

let readNumbers =
    let lines = File.ReadAllLines("..\..\..\input")
    lines |> Seq.map Int32.Parse

[<EntryPoint>]
let main argv =
    let numbers = readNumbers

    printfn "%d" (Seq.item 0 (Part1.execute numbers))
    printfn "%d" (Seq.item 0 (Part2.execute numbers))
    0
