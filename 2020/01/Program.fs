open System
open System.IO

let readNumbers =
    let lines = File.ReadAllLines("..\..\..\input")
    lines |> Seq.map Int32.Parse

let part1 = seq {
    let numbers = readNumbers
    for i = 0 to Seq.length numbers - 1 do
        let a = Seq.item i numbers
        let others = Seq.filter (fun x -> x <> a && a + x = 2020) numbers
        if not (Seq.isEmpty others) then
            let b = Seq.item 0 others
            yield a * b
}

let part2 = seq {
    let numbers = readNumbers
    for i = 0 to Seq.length numbers - 1 do
        let a = Seq.item i numbers
        let itemsJ = Seq.filter (fun x -> x <> a && a + x < 2020) numbers
        for j in 0 .. Seq.length itemsJ - 1 do
            let b = Seq.item j itemsJ
            let itemsK = Seq.filter (fun x -> x <> b && b + x = 2020) numbers
            if not (Seq.isEmpty itemsK) then
                let c = Seq.item 0 itemsK
                yield a * b * c
}

[<EntryPoint>]
let main argv =
    printfn "%d" (Seq.item 0 part1)
    printfn "%d" (Seq.item 0 part2)
    0
