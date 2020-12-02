module Part1
open Input

let validPasswordPart(input: input) =
    let mutable count = 0
    for char in input.password do
        if char = input.char then
            count <- count + 1
    count >= input.min && count <= input.max

let execute(inputs) =
    let mutable valid = 0
    for input in inputs do
        if validPasswordPart input then
            valid <- valid + 1
    valid