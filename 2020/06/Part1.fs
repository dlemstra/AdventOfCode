module Part1
open Input
open System.Linq
open System

let execute(inputs: seq<input>) =

    let allCharacters = inputs |> Seq.map (fun input -> String.Concat(input.lines).ToCharArray())
    let distinctCount = allCharacters |> Seq.map (fun characters -> (Seq.distinct characters).Count())
    Seq.sum distinctCount
