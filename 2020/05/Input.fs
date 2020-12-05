module Input

open System.IO

type input(data: string) =
    member this.data = data.ToCharArray()

let read = seq<input> {
    let lines = File.ReadAllLines("..\..\..\input")

    for line in lines do
        yield input(line)
}