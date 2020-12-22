module Part1

open Input

let getTotal(deck: int[]) =
    let mutable total = 0
    let mutable multiplier = deck.Length
    for card in deck do
        total <- total + (card * multiplier)
        multiplier <- multiplier - 1
    total

let execute(inputs: seq<input>) =
    let size = (Seq.item 0 inputs).cards.Length * 2

    let mutable deck0 = Array.zeroCreate<int> size
    let mutable deck1 = Array.zeroCreate<int> size

    let mutable count0 = 0
    for card in (Seq.item 0 inputs).cards do
        deck0.[count0] <- card
        count0 <- count0 + 1

    let mutable count1 = 0
    for card in (Seq.item 1 inputs).cards do
        deck1.[count1] <- card
        count1 <- count1 + 1

    while count0 <> size && count1 <> size do
        let card0 = deck0.[0]
        let card1 = deck1.[0]
        if card0 > card1 then
            for i = 1 to count0 do
                deck0.[i - 1] <- deck0.[i]

            deck0.[count0 - 1] <- card0
            deck0.[count0] <- card1
            count0 <- count0 + 1

            for i = 1 to count1 do
                deck1.[i - 1] <- deck1.[i]

            count1 <- count1 - 1
        else
            for i = 1 to count1 do
                deck1.[i - 1] <- deck1.[i]

            deck1.[count1 - 1] <- card1
            deck1.[count1] <- card0
            count1 <- count1 + 1

            for i = 1 to count0 do
                deck0.[i - 1] <- deck0.[i]

            count0 <- count0 - 1

    if deck0.[0] = 0 then
        getTotal(deck1)
    else
        getTotal(deck0)