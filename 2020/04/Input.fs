module Input

open System.IO
open System.Collections.Generic

type input(fields: Dictionary<string,string>) =
    member this.fields = fields

let read = seq<input> {
    let lines = File.ReadAllLines("..\..\..\input")

    let mutable fields = Dictionary<string,string>()
    for line in lines do
        if line.Length = 0 then
            yield input(fields)
            fields <- Dictionary<string,string>()
        else
            for field in line.Split(' ') do
                let keyValue = field.Split(':')
                fields.Add(keyValue.[0], keyValue.[1])

    yield input(fields)
}