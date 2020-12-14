module Part2

open Input
open System
open System.Collections.Generic

let rec getPermutationsWithRepetition n lst = 
    match n, lst with
    | 0, _ -> seq [[]]
    | _, [] -> seq []
    | k, _ -> lst |> Seq.collect (fun x -> Seq.map ((@) [x]) (getPermutationsWithRepetition (k - 1) lst))

let readMask(mask: string) =
    mask.Substring(7, mask.Length - 7).ToCharArray() |> Seq.rev |> Seq.indexed

let getInitialValue(value: int64, mask: seq<int * char>) =
    let mutable result = value
    let oneIndexes = mask |> Seq.filter (fun (_, item) -> item = '1') |> Seq.map (fun (index, _) -> index)
    for index in oneIndexes do
        result <- result ||| (1L <<< index)
    result

let applyMask(value: int64, floatingIndexes: seq<int>, floatingBits: list<char>) =
    let mutable result = value
    let mutable i = 0

    for index in floatingIndexes do
        if floatingBits.[i] = '0' then
            result <- result &&& ~~~(1L <<< index)
        else
            result <- result ||| (1L <<< index)
        i <- i + 1
    result

let setMemory(memory: Dictionary<int64, int64>, mask: seq<int * char>, action: string) =
    let info = action.Split(" = ")
    let startValue = Int64.Parse (info.[0].Substring(4, info.[0].Length - 5))
    let value = Int64.Parse info.[1]

    let initialValue = getInitialValue(startValue, mask)
    let floatingIndexes = mask |> Seq.filter (fun (_, item) -> item = 'X') |> Seq.map (fun (index, _) -> index)

    let count = Seq.length floatingIndexes
    for floatingBits in getPermutationsWithRepetition count ['0';'1'] do
        let address = applyMask(initialValue, floatingIndexes, floatingBits)
        memory.[address] <- value

let execute(inputs: seq<input>) =
    let mutable mask = Seq.empty<int * char>

    let memory = new Dictionary<int64, int64>()

    for input in inputs do
        match input.action.[1] with
            | 'a' -> mask <- readMask input.action
            | 'e' -> setMemory(memory, mask, input.action)
            | _ -> failwith "unknown action"

    memory.Values |> Seq.sum
