module Part2

open Types

//                   # 
// #    ##    ##    ###
//  #  #  #  #  #  #   
// 01234567890123456789
let isSeaMonster(tile: tile, x, y) =
    tile.[x + 5, y] = '#' && tile.[x + 6, y] = '#' && tile.[x + 11, y] = '#' && tile.[x + 12, y] = '#' &&
    tile.[x + 17, y] = '#' && tile.[x + 18, y] = '#' && tile.[x + 19, y] = '#' &&
    tile.[x + 18, y - 1] = '#' &&
    tile.[x + 1, y + 1] = '#' && tile.[x + 4, y + 1] = '#' && tile.[x + 7, y + 1] = '#' &&
    tile.[x + 10, y + 1] = '#' && tile.[x + 13, y + 1] = '#' && tile.[x + 16, y + 1] = '#'

let findSeaMonster(tile: tile) =
    let mutable total = 0

    for y in 1 .. tile.maxY - 1 do
        let mutable x = 0

        while x < tile.maxX - 19 do
            if tile.[x, y] = '#' && isSeaMonster(tile, x, y) then
                total <- total + 1
                x <- x + 20
            else
                x <- x + 1

    total

let createTile(input: tileGrid) =
    let size = input.width * (input.[0, 0].width - 2)
    let result = tile(0L, size)

    let mutable y1 = 0
    let mutable x1 = 0
    for y in 0 .. input.maxY do
        for yy in 1 .. input.[0, 0].maxY - 1 do
            x1 <- 0
            for x in 0 .. input.maxX do
                let tile = input.[x, y]
                for xx in 1 .. tile.maxX - 1 do
                    result.[x1, y1] <- tile.[xx, yy]
                    x1 <- x1 + 1
            y1 <- y1 + 1

    result.setViews()
    result

let execute(input: tileGrid) =
    let mutable total = 0

    let tile = createTile(input)

    let mutable i = 0
    while total = 0 && i < tile.views.Length do
        let view = tile.views.[i]
        let found = findSeaMonster(view)
        if found > 0 then
            total <- (view.getData() |> Seq.filter (fun x -> x = '#') |> Seq.length) - (found * 15)
            i <- tile.views.Length
        i <- i + 1
    total
