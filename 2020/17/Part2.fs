module Part2

open Input
open System.Collections.Generic

type position = { x: int; y: int; z: int; w: int }

let neighbours(x: int, y: int, z: int, w: int) = seq {
    for x1 = x - 1 to x + 1 do
       for y1 = y - 1 to y + 1 do
           for z1 = z - 1 to z + 1 do
                for w1 = w - 1 to w + 1 do
                    if (x1 = x) && (y1 = y) && (z1 = z) && (w1 = w) then
                        ()
                    else
                        { x = x1; y = y1; z = z1; w = w1 }
}

let isActive(cubes: Dictionary<position, bool>, position: position) =
    cubes.ContainsKey(position) && cubes.[position]

let activeNeighbours(cubes: Dictionary<position, bool>, x: int, y: int, z: int, w: int) =
    let mutable active = 0

    for position in neighbours(x, y, z, w) do
        if isActive(cubes, position) then
            active <- active + 1
    active

let expandGrid(cubes: Dictionary<position, bool>, min: int, max: int, z: int, w: int) = seq {
    for y = min - 1 to max + 1 do
        for x = min - 1 to max + 1 do
            let position = { x = x; y = y; z = z; w = w }
            let activeCount = activeNeighbours(cubes, x, y, z, w)

            if isActive(cubes, position) then
                yield (position, (activeCount = 2 || activeCount = 3))
            else
                yield (position, activeCount = 3)
}

let countActive(cubes: Dictionary<position, bool>) =
    cubes.Values |> Seq.filter (fun value -> value = true) |> Seq.length

let execute(inputs: seq<input>) =
    let size = Seq.length inputs

    let mutable cubes = Dictionary<position, bool>()

    let mutable y = 0
    while y < size do
        let input = Seq.item y inputs
        for x = 0 to size - 1 do
            let active = input.characters.[x] = '#'
            let pos = { x = x; y = y; z = 0; w = 0 }
            cubes.[pos] <- active
        y <- y + 1

    let mutable minLevel = -1
    let mutable maxLevel = 1

    let mutable min = 0
    let mutable max = size - 1

    while maxLevel <= 6 do
        let newCubes = new Dictionary<position, bool>()

        for z = minLevel to maxLevel do
            for w = minLevel to maxLevel do
                for position, status in expandGrid(cubes, min, max, z, w) do
                    newCubes.[position] <- status

        cubes <- newCubes

        minLevel <- minLevel - 1
        maxLevel <- maxLevel + 1

        min <- min - 1
        max <- max + 1

    countActive cubes
