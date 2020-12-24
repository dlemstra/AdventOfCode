module Part2

open Input
open System.Collections.Generic

type position = { x: int; y: int }

let allNeighbours(pos: position) = seq {
    yield { x = pos.x + 1; y = pos.y + 0; }
    yield { x = pos.x + 1; y = pos.y - 1; }
    yield { x = pos.x + 0; y = pos.y - 1; }
    yield { x = pos.x - 1; y = pos.y + 0; }
    yield { x = pos.x - 1; y = pos.y + 1; }
    yield { x = pos.x + 0; y = pos.y + 1; }
}

let blackNeighboursCount(blackTiles: HashSet<position>, pos: position) =
    (Seq.truncate 3 (allNeighbours(pos) |> Seq.filter (fun tile -> blackTiles.Contains(tile)))) |> Seq.length

let execute(inputs: input seq) =
    let mutable blackTiles = new HashSet<position>()

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
        if blackTiles.Contains(pos) then
            blackTiles.Remove(pos) |> ignore
        else
            blackTiles.Add(pos) |> ignore

    for _ in 1 .. 100 do
        let newBlackTiles = new HashSet<position>()
        for blackTile in blackTiles do
            let count = blackNeighboursCount(blackTiles, blackTile)
            if count = 1 || count = 2 then
                newBlackTiles.Add(blackTile) |> ignore

        let whiteTiles =
            blackTiles
            |> Seq.map (fun blackTile -> allNeighbours(blackTile))
            |> Seq.concat
            |> Seq.distinct
            |> Seq.filter (fun tile -> not(blackTiles.Contains(tile)))

        for whiteTile in whiteTiles do
            if blackNeighboursCount(blackTiles, whiteTile) = 2 then
                newBlackTiles.Add(whiteTile) |> ignore

        blackTiles <- newBlackTiles

    blackTiles.Count
