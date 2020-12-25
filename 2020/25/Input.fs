module Input

open System
open System.IO

type input(result: int64) =
    member this.result = result

let read = seq {
    let lines = File.ReadAllLines("..\..\..\input")
    for line in lines do
        yield input(Int64.Parse line)
}
