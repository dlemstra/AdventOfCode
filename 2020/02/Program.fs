open System
open System.IO
open Input

let readInput =
    let lines = File.ReadAllLines("..\..\..\input")
    lines |>  Seq.map (fun line ->
        let data = line.Split(' ')
        let range = data.[0].Split('-')
        let min = Int32.Parse range.[0]
        let max = Int32.Parse range.[1]
        new input(min, max, data.[1].[0], data.[2])
    )

[<EntryPoint>]
let main argv =
    let inputs = readInput

    printfn "%d" (Part1.execute inputs)
    printfn "%d" (Part2.execute inputs)
    0
