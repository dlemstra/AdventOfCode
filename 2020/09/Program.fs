[<EntryPoint>]
let main _ =
    let inputs = Input.read

    let part1 = Part1.execute inputs
    printfn "Part1: %d" part1

    let part2 = Part2.execute inputs
    printfn "Part2: %d" part2
    0
