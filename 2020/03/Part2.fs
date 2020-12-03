module Part2
open Input

let countTrees(inputs: seq<input>, stepSize: int, lineStepSize: int) =
    let mutable trees = 0
    let mutable offset = stepSize
    let mutable lineNumber = lineStepSize

    let length = (Seq.item 0 inputs).line.Length
    let lineCount = Seq.length inputs
    while lineNumber < lineCount do
        let line = (Seq.item lineNumber inputs).line
        if line.[offset % length] = '#' then
            trees <- trees + 1
        offset <- offset + stepSize
        lineNumber <- lineNumber + lineStepSize

    trees

let execute(inputs: seq<input>) =
    let mutable trees = 1

    trees <- trees * countTrees(inputs, 1, 1)
    trees <- trees * countTrees(inputs, 3, 1)
    trees <- trees * countTrees(inputs, 5, 1)
    trees <- trees * countTrees(inputs, 7, 1)
    trees <- trees * countTrees(inputs, 1, 2)

    trees