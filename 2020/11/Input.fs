module Input

open System.IO

type input(line: string) =
    member this.line = line

let read = seq<input> {
    let lines = File.ReadAllLines("..\..\..\input")

    for line in lines do
        yield input(line)
}