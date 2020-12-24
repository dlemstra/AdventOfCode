module Part1

open Input
open System.Collections.Generic

type position = { x: int; y: int }

let execute(inputs: input seq) =
    let tiles = new Dictionary<position, char>()

    for input in inputs do
        let mutable pos = { x = 0; y = 0 }
        for direction in input.directions.Split(',') do
            match direction with
                | "e"  -> pos <- { x = pos.x + 1; y = pos.y + 0; }
                | "se" -> pos <- { x = pos.x + 1; y = pos.y - 1; }
                | "sw" -> pos <- { x = pos.x + 0; y = pos.y - 1; }
                | "w"  -> pos <- { x = pos.x - 1; y = pos.y + 0; }
                | "nw" -> pos <- { x = pos.x - 1; y = pos.y + 1; }
                | "ne" -> pos <- { x = pos.x + 0; y = pos.y + 1; }
                | _ -> failwith "not implemented"
        if tiles.ContainsKey(pos) then
            tiles.[pos] <- if tiles.[pos] = 'w' then 'b' else 'w'
        else
            tiles.[pos] <- 'b'

    (tiles.Values |> Seq.filter (fun x -> x = 'b') |> Seq.length)