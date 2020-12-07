module Part1

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

let rec containsShiny(color: string, bags: Dictionary<string, list<contains>>) =
    if color = "shiny gold" then
        true
    else
        let containList = bags.[color]
        let result = containList |> Seq.map (fun contains -> containsShiny(contains.color, bags)) |> Seq.filter (fun x -> x = true)
        result.Any()

let execute(inputs: seq<input>) =
    let bags = createBags(inputs)

    let otherBags = bags.Keys |> Seq.filter (fun color-> color <> "shiny gold")

    let bagsThatContainsShiny = otherBags |> Seq.map (fun color -> containsShiny(color, bags)) |> Seq.filter (fun x -> x = true)

    bagsThatContainsShiny.Count()
