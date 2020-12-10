module Input

open System.IO

type input(number: string) =
    member this.number = number

let read = seq<input> {
    let lines = File.ReadAllLines("..\..\..\input")

    for line in lines do
        yield input(line)
}