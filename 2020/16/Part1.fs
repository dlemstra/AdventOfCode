module Part1

open Input

let inRange(range: range, number: int) =
    number >= range.min && number <= range.max

let invalidNumbers(ticket: ticket, restrictions: list<restriction>) = seq {
    for number in ticket.numbers do
        let mutable i = 0
        let mutable valid = false
        while valid = false && i < restrictions.Length do
            valid <- inRange(restrictions.[i].first, number) || inRange(restrictions.[i].second, number)
            i <- i + 1
        if not valid then
            yield number
}

let invalidTickets(input: input) = seq {
    for ticket in input.nearByTickets do
        let invalidNumbers = invalidNumbers(ticket, input.restrictions)
        if not (Seq.isEmpty invalidNumbers) then
            yield ticket, invalidNumbers |> Seq.sum
}

let execute(input: input) =
    let result = invalidTickets input
    let errorRate = result |> Seq.map snd |> Seq.sum
    let invalidTickets = result |> Seq.map fst

    let validTickets = input.nearByTickets |> Seq.filter (fun ticket -> not (Seq.contains ticket invalidTickets)) |> Seq.toList

    errorRate, validTickets
