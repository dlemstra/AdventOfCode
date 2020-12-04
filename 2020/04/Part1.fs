module Part1
open Input

let requiredFields = ["byr";"iyr";"eyr";"hgt";"hcl";"ecl";"pid"]

let requiredFieldCount(input: input) =
    let mutable count = 0
    for requiredField in requiredFields do
        if input.fields.ContainsKey(requiredField) then
            count <- count + 1

    count

let execute(inputs: seq<input>) =
    let mutable valid = 0
    for input in inputs do
        if requiredFieldCount(input) = requiredFields.Length then
            valid <- valid + 1

    valid