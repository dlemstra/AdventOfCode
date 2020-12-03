module Part1
open Input

let execute(inputs: seq<input>) =
    let mutable trees = 0
    let mutable offset = 3

    let length = (Seq.item 0 inputs).line.Length;
    for lineNumber in 1 .. (Seq.length inputs) - 1 do
        let line = (Seq.item lineNumber inputs).line
        if line.[offset % length] = '#' then
            trees <- trees + 1
        offset <- offset + 3

    trees