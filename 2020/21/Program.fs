[<EntryPoint>]
let main _ =
    let inputs = Input.read

    let part1, translations = Part1.execute inputs
    printfn "Part1: %d" part1

    let part2 = Part2.execute translations
    printfn "Part2: %s" part2

    0
