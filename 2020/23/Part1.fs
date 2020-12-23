module Part1

open Input
open System

let print(numbers: int[], move: int, current: int, destination: int) =
    printfn "-- move %d --" move
    printf "cups: "
    for i = 0 to numbers.Length - 1 do
        if i = current then
            printf "(%d) " numbers.[i]
        else
            printf "%d "  numbers.[i]
    printfn ""
    printf "pick up: "
    for i = current + 1 to current + 3 do
        printf "%d " numbers.[i % numbers.Length]
    printfn ""
    printfn "destination: %d" destination
    printfn ""

let rec findDestination(numbers: int[], current: int, destination: int) =
    if destination = 0 then
        findDestination(numbers, current, Seq.max numbers)
    else
        let mutable found = false
        for i = 1 to 3 do
            if numbers.[(current + i) % numbers.Length] = destination then found <- true

        if found then findDestination(numbers, current, destination - 1) else destination

let execute(input: input) =
    let mutable size = Seq.length input.numbers

    let mutable current = 0
    let mutable numbers = Array.zeroCreate size

    for number in input.numbers do
        numbers.[current] <- number
        current <- current + 1

    current <- 0
    let mutable destinationCup = 0

    for move in 1 .. 100 do
        destinationCup <- findDestination(numbers, current, numbers.[current] - 1)

        // print(numbers, move, current, destinationCup)

        let newNumbers = Array.zeroCreate size
        for i = 4 to size do
            let source = (current + i) % size
            let target = (current + size + i - 3) % size
            newNumbers.[target] <- numbers.[source]

        let index = ((newNumbers |> Seq.findIndex (fun number -> number = destinationCup)) + 1) % size

        let mutable lastZero = (index + size - 1) % size
        while newNumbers.[lastZero] <> 0 do
            lastZero <- (lastZero + size - 1) % size

        let stop = (index + 2) % size

        let mutable i = lastZero

        while i <> stop do
            let source = (i + size - 3) % size
            let target = i
            newNumbers.[target] <- newNumbers.[source]
            i <- (i + size - 1) % size

        for i = 0 to 2 do
            let source = (current + 1 + i) % size
            let target = (index + i) % size
            newNumbers.[target] <- numbers.[source]

        numbers <- newNumbers

        current <- (current + 1) % size

    let indexOfOne = numbers |> Seq.findIndex (fun number -> number = 1)

    let mutable result = ""
    for i = 1 to size - 1 do
        result <- result + numbers.[(indexOfOne + i) % size].ToString()

    Int32.Parse(result)