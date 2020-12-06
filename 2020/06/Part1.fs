module Part1
open Input
open System.Linq

let execute(inputs: seq<input>) =

    let distinctCount = inputs |> Seq.map (fun input -> (Seq.distinct input.data).Count())
    Seq.sum distinctCount