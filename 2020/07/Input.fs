module Input

open System.IO

type input(rule: string) =
    member this.rule = rule

let read = seq<input> {
    let lines = File.ReadAllLines("..\..\..\input")

    let mutable data = []
    for line in lines do
        yield input(line)
}