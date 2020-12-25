[<EntryPoint>]
let main _ =
    let inputs = Input.read

    let part1 = Part1.execute inputs
    printfn "Part1: %d" part1

    0
