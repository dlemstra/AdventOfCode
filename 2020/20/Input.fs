module Input

open System.IO

type input(data: string list) =
    member this.data = data

let read = seq {
    let lines = File.ReadAllLines("..\..\..\input")

    let mutable data = []
    for line in lines do
        if line = "" then
            yield input(data)
            data <- []
        else
            data <- data @ [line]
    yield input(data)
}