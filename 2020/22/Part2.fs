module Part2

open Input

let cardSum(cards: int[], count: int) =
    let mutable total = 0
    let mutable multiplier = cards.Length
    for i = 0 to count - 1 do
        total <- total + (cards.[i] * multiplier)
        multiplier <- multiplier - 1
    total

let checkSum(cards: int[], count: int) =
    let mutable total = 0L
    let mutable multiplier = 1L
    for i = 0 to count - 1 do
        total <- total + (int64 cards.[i] * multiplier)
        multiplier <- multiplier * 10L
    total

type deck(input: int list, size: int) =
    let mutable count = input.Length
    let cards = Array.concat [ input |> Seq.toArray ; (Array.zeroCreate<int> (size - input.Length)) ]
    let mutable checkSums = [checkSum(cards, count)]

    member this.topCard = cards.[0]
    member this.cardCount = count
    member this.winner = count = cards.Length
    member this.deadlock = checkSums.Length = 0

    member this.won(card: int) =
        let topCard = cards.[0]

        for i = 1 to count do
            cards.[i - 1] <- cards.[i]

        cards.[count - 1] <- topCard
        cards.[count] <- card

        count <- count + 1
        this.addSum()

    member this.lost() =
        for i = 1 to count do
            cards.[i - 1] <- cards.[i]

        count <- count - 1
        this.addSum()

    member this.value() =
        cardSum(cards, count)

    member this.subGameDeck(size: int, totalSize: int) =
        deck(cards.[1 .. size] |> Seq.toList, totalSize)

    member private this.addSum() =
        let checkSum = checkSum(cards, count)
        if Seq.contains checkSum checkSums then
            checkSums <- []
        else
            checkSums <- checkSums @ [checkSum]

let rec playGame(deck1: deck, deck2: deck) =
    let mutable result = 0

    while result = 0 do
        if deck1.winner || deck1.deadlock then
            result <- -deck1.value()
        elif deck2.winner then
            result <- deck2.value()
        else
            let mutable deck1Won = deck1.topCard > deck2.topCard

            if (deck1.cardCount - 1) >= deck1.topCard && (deck2.cardCount - 1) >= deck2.topCard then
                let subDeck1Count = deck1.topCard
                let subDeck2Count = deck2.topCard

                let subDeck1 = deck1.subGameDeck(subDeck1Count, subDeck1Count + subDeck2Count)
                let subDeck2 = deck2.subGameDeck(subDeck2Count, subDeck1Count + subDeck2Count)
                let subResult = playGame(subDeck1, subDeck2)
                deck1Won <- subResult < 0

            if deck1Won then
                deck1.won(deck2.topCard)
                deck2.lost()
            else
                deck2.won(deck1.topCard)
                deck1.lost()

    result


let execute(inputs: seq<input>) =
    let size = (Seq.item 0 inputs).cards.Length * 2

    let deck1 = deck((Seq.item 0 inputs).cards, size)
    let deck2 = deck((Seq.item 1 inputs).cards, size)

    let result = playGame(deck1, deck2)

    abs result
