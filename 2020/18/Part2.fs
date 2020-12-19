module Part2

open Input
open System

type valueType = Number | Add | Multiply

type value(valueType: valueType, ?value: int64) =
    member this.valueType = valueType
    member this.value = defaultArg value -1L

let evaluatePlus(values: list<value>) =
    let mutable result = [values.[0]]

    let mutable i = 1
    while i < values.Length do
        if values.[i].valueType = Add then
            result <- result.[0 .. result.Length - 2] @ [value(Number, result.[result.Length - 1].value + values.[i + 1].value)]
            i <- i + 2
        else
            result <- result @ [values.[i]]
            i <- i + 1
    result

let evaluateMultiply(values: list<value>) =
    let mutable result = values.[0].value
    let mutable i = 1
    while i < values.Length do
        match values.[i].valueType with
            | Multiply -> result <- result * values.[i + 1].value
            | _ -> failwith "Invalid status"
        i <- i + 2
    result

let getSubString(input: string) =
    let mutable result = input.Substring(1, input.Length - 2)
    let mutable i = 0
    let mutable depth = 0
    while i < result.Length do
        if input.[i] = '(' then
            depth <- depth + 1
        elif input.[i] = ')' then
            depth <- depth - 1
            if depth = 0 then
                result <- result.Substring(0, i - 1)
                i <- result.Length
        i <- i + 1
    result

let rec compute(input: string) =
    let mutable values = []

    let mutable number = -1L
    let mutable i = 0
    while i < input.Length do
        match input.[i] with
            | '(' ->
                let subString = getSubString(input.Substring(i))
                values <- values @ [value(Number, compute(subString))]
                i <- i + subString.Length + 2
            | '*' -> values <- values @ [value(Multiply)]
            | '+' -> values <- values @ [value(Add)]
            | ' ' ->
                if number <> -1L then
                    values <- values @ [value(Number, number)]
                    number <- -1L
            | _ ->
                let value = Int64.Parse(input.[i].ToString())
                if number = -1L then
                    number <- value
                else
                    number <- (number * 10L) + value
        i <- i + 1

    if number <> -1L then
        values <- values @ [value(Number, number)]

    values <- evaluatePlus values
    evaluateMultiply values

let execute(inputs: seq<input>) =
    inputs |> Seq.map (fun input -> compute input.line) |> Seq.sum
