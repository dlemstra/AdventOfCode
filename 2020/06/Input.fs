module Input

open System.IO

type input(data: list<char>) =
    member this.data = data

let read = seq<input> {
    let lines = File.ReadAllLines("..\..\..\input")

    let mutable data = []
    for line in lines do
        if line.Length = 0 then
            yield input(data)
            data <- []
        else
            data <- (line.ToCharArray() |> List.ofArray) @ data
    yield input(data)
}