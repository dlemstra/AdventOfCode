module Part2

open Input
open System
open System.Linq
open System.Collections.Generic

type contains(color: string, count: int) =
    member this.color = color
    member this.count = count

let createContains(inputs: seq<string>) = seq {
    for input in inputs do
        let info = input.Split(" ")
        let color = String.Join(" ", info.Skip(1)).Trim()
        yield contains(color, Int32.Parse(info.[0]))
}

let createBags(inputs: seq<input>) =
    let bags = new Dictionary<string, list<contains>>()

    for input in inputs do
        let rule = input.rule.Replace("bags", "").Replace("bag", "")
        let info = rule.Split("contain")
        let color = info.[0].Trim()
        let contains = info.[1].TrimEnd('.').Trim()
        match contains with
            | "no other" -> bags.Add(color, [])
            | _ ->  bags.Add(color, createContains(contains.Split(", ")) |> Seq.toList)

    bags

let rec bagCount(color: string, bags: Dictionary<string, list<contains>>) =
    let containsList = bags.[color]
    if containsList.Length = 0 then
        0
    else
        let mutable count = 0
        for contains in containsList do
            count <- count + contains.count + (bagCount(contains.color, bags) * contains.count)
        count

let execute(inputs: seq<input>) =
    let bags = createBags(inputs)

    bagCount("shiny gold", bags)
