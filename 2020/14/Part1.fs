module Part1

open Input
open System
open System.Collections.Generic

let readMask(mask: string) =
    mask.Substring(7, mask.Length - 7).ToCharArray() |> Seq.rev |> Seq.toArray

let applyMask(value: int64, mask: char[]) =
    let mutable result = value
    for i in 0 .. mask.Length - 1 do
        result <-
            match mask.[i] with
                | '0' -> result &&& ~~~(1L <<< i)
                | '1' -> result ||| (1L <<< i)
                | _ -> result
    result

let setMemory(memory: Dictionary<int, int64>, mask: char[], action: string) =
    let info = action.Split(" = ")
    let address = Int32.Parse (info.[0].Substring(4, info.[0].Length - 5))
    let value = applyMask(Int64.Parse info.[1], mask)
    memory.[address] <- value

let execute(inputs: seq<input>) =
    let mutable mask = Array.zeroCreate<char> 0

    let memory = new Dictionary<int, int64>()

    for input in inputs do
        match input.action.[1] with
            | 'a' -> mask <- readMask input.action
            | 'e' -> setMemory(memory, mask, input.action)
            | _ -> failwithf "Unknown action"

    memory.Values |> Seq.sum