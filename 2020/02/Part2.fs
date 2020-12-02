module Part2
open Input

let validPasswordPart(input: input) =
    let first = input.password.[input.min - 1]
    let second = input.password.[input.max - 1]

    if first = input.char && second = input.char then
        false
    else
        first = input.char || second = input.char

let execute(inputs) =
    let mutable valid = 0
    for input in inputs do
        if validPasswordPart input then
            valid <- valid + 1
    valid