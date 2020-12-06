[<EntryPoint>]
let main argv =
    let inputs = Input.read

    printfn "%d" (Part1.execute inputs)
    printfn "%d" (Part2.execute inputs)
    0
