module Input

open System.IO

type input(instruction: string) =
    member this.instruction = instruction

let read = seq<input> {
    let lines = File.ReadAllLines("..\..\..\input")

    for line in lines do
        yield input(line)
}