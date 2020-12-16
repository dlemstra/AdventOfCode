module Part2

open Input

let inRange(range: range, number: int) =
    number >= range.min && number <= range.max

let validNumber(restriction: restriction, number: int) =
    inRange(restriction.first, number) || inRange(restriction.second, number)

let allNumberWithinRestriction(restriction: restriction, numbers: seq<int>) =
    let valid = numbers |> Seq.filter (fun number -> validNumber(restriction, number)) |> Seq.length
    valid = Seq.length numbers

let execute(input: input, validTickets: list<ticket>) =
    let restrictions = Array.zeroCreate<restriction> (Seq.length input.restrictions)

    let mutable remainingRestrictions = seq input.restrictions

    while Seq.length remainingRestrictions <> 0 do
        let mutable i = 0
        let mutable found = false
        while found = false && i < input.ticket.numbers.Length do
            let number = input.ticket.numbers.[i]
            let numbers = Seq.append (validTickets |> Seq.map (fun ticket -> ticket.numbers.[i])) [number]

            let validRestrictions = remainingRestrictions |> Seq.filter (fun restriction -> allNumberWithinRestriction(restriction, numbers))

            if (Seq.length validRestrictions) = 1 then
                let validRestriction = Seq.item 0 validRestrictions
                remainingRestrictions <- remainingRestrictions |> Seq.filter (fun restriction -> restriction <> validRestriction)
                found <- true
                restrictions.[i] <- validRestriction

            i <- i + 1

    let mutable result = 1L
    for i in 0 .. restrictions.Length - 1 do
        if restrictions.[i].name.Contains("departure") then
            result <- result * int64 input.ticket.numbers.[i]

    result
