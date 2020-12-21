module Input

open System.IO

type input(words: string list, allergens: string list) =
    member this.words = words
    member this.allergens = allergens

let read = seq {
    let lines = File.ReadAllLines("..\..\..\input")

    for line in lines do
        let info = line.Replace(",", "").Replace(")", "").Split(" (contains ")

        yield input(info.[0].Split(' ') |> Seq.toList, info.[1].Split(' ') |> Seq.toList)
}