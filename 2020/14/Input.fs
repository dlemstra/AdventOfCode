module Input

open System.IO

type input(action: string) =
    member this.action = action

let read = seq<input> {
    let lines = File.ReadAllLines("..\..\..\input")

    for line in  lines do
        yield input(line)
}