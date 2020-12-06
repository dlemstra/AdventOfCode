module Input

open System.IO

type input(lines: list<string>) =
    member this.lines = lines

let read = seq<input> {
    let lines = File.ReadAllLines("..\..\..\input")

    let mutable data = []
    for line in lines do
        if line.Length = 0 then
            yield input(data)
            data <- []
        else
            data <- line :: data
    yield input(data)
}