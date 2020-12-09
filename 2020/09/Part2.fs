module Part2

open Input
open System
open System.Linq

let getNumbers(inputs: seq<input>) = seq {
    for input in inputs do
        yield Int64.Parse(input.number)
}

let getTotal(numbers: list<int64>, part1: int64, offset: int) =
    let mutable position = offset
    let mutable total = 0L
    while total < part1 do
        total <- total + numbers.[position]
        position <- position + 1
    (total = part1, position)

let findNumber(numbers: list<int64>, part1: int64) =
    let mutable i = 0
    let mutable number = 0L
    while number = 0L do
        let valid, offset = getTotal(numbers, part1, i)
        if valid then
            let range = numbers.Skip(i).Take(offset - i)
            let min = Seq.min range
            let max = Seq.max range
            number <- min + max
        else
            i <- i + 1
    number

let execute(inputs: seq<input>, part1: int64) =
    let numbers = List.ofSeq (getNumbers inputs)
    findNumber(numbers, part1)
