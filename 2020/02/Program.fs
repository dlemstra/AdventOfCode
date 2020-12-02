open System
open System.IO

type input(min, max, char, password) =
    member this.min = min
    member this.max = max
    member this.char = char
    member this.password = password

let readInput =
    let lines = File.ReadAllLines("..\..\..\input")
    lines |>  Seq.map (fun line ->
        let data = line.Split(' ')
        let range = data.[0].Split('-')
        let min = Int32.Parse range.[0]
        let max = Int32.Parse range.[1]
        new input(min, max, data.[1].[0], data.[2])
    )

let validPassword(input: input) =
    let mutable count = 0
    for char in input.password do
        if char = input.char then
            count <- count + 1
    count >= input.min && count <= input.max

let part1 =
    let inputs = readInput

    let mutable valid = 0
    for input in inputs do
        if validPassword input then
            valid <- valid + 1
    valid


[<EntryPoint>]
let main argv =
    printfn "%d" part1
    0
