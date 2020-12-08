[<EntryPoint>]
let main _ =
    let inputs = Input.read

    printfn "Part1: %d" (Part1.execute inputs)
    printfn "Part2: %d" (Part2.execute inputs)
    0
