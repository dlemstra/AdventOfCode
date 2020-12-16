module Part1

open Input

let inRange(range: range, number: int) =
    number >= range.min && number <= range.max

let invalidNumbers(input: input) = seq {

    for ticket in input.nearByTickets do
        for number in ticket.numbers do
            let mutable i = 0
            let mutable valid = false
            while valid = false && i < input.restrictions.Length do
                valid <- inRange(input.restrictions.[i].first, number) || inRange(input.restrictions.[i].second, number)
                i <- i + 1
            if not valid then
                yield number
}

let execute(input: input) =
    invalidNumbers input |> Seq.sum
