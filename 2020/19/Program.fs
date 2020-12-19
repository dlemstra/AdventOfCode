[<EntryPoint>]
let main _ =
    let input = Input.read

    let part1 = Part1.execute input
    printfn "Part1: %d" part1

    let part2 = Part2.execute input
    printfn "Part2: %d" part2

    0
