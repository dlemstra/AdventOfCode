module Part2

open Input
open System
open System.Linq

let validNumber(input: string, min: int, max: int) =
    let mutable value = 0
    if Int32.TryParse(input, &value) then
        value >= min && value <= max
    else
        false

let validHeight(input: string) =
    if input.EndsWith("cm") then
        validNumber(input.Substring(0, input.Length - 2), 150, 193)
    elif input.EndsWith("in") then
        validNumber(input.Substring(0, input.Length - 2), 59, 76)
    else
        false

let validHairColor(input: string) =
    if input.Length <> 7 then
        false
    elif input.[0] <> '#' then
        false
    else
        let characters = input.Substring(1) |> Seq.map (fun c -> (int) c)
        characters.All(fun c -> (c >= 48 && c <= 57) || (c >= 97 && c <= 102))

let validEyeColor(input: string) =
    let validColors = ["amb"; "blu"; "brn"; "gry"; "grn"; "hzl"; "oth"]
    validColors.Contains(input)

let validPassportId(input: string) =
    if input.Length <> 9 then
        false
    else
        input.All(fun c -> Char.IsDigit(c))

let validCount(input: input) =
    let mutable count = 0
    for key in input.fields.Keys.Except(["cid"]) do
        let value = input.fields.[key]
        let valid =
            match key with
                | "byr" -> validNumber(value, 1920, 2002)
                | "iyr" -> validNumber(value, 2010, 2020)
                | "eyr" -> validNumber(value, 2020, 2030)
                | "hgt" -> validHeight(value)
                | "hcl" -> validHairColor(value)
                | "ecl" -> validEyeColor(value)
                | "pid" -> validPassportId(value)
                | _ -> false

        if valid then
            count <- count + 1
    count

let execute(inputs: seq<input>) =
    let mutable valid = 0
    for input in inputs do
        if validCount(input) = 7 then
            valid <- valid + 1

    valid