module Part1

open Input
open Types
open System

let createTiles(inputs: input seq) = seq {
    for input in inputs do
        let header = input.data.[0]
        let id = Int64.Parse (header.Substring(5, header.Length - 6))
        let size = header.Length
        let tile = tile(id, size)

        let mutable y = 0
        for line in Seq.skip 1 input.data do
            let mutable x = 0
            for char in line do
                tile.[x, y] <- char
                x <- x + 1
            y <- y + 1

        tile.setViews()

        yield tile
}

let remove(tiles: tile seq, tile: tile) =
    tiles |> Seq.filter (fun t -> t.id <> tile.id) |> Seq.toList

let findPossibleLeft(grid: tileGrid, x: int, y: int, remaining: tile seq) = seq {
    let left = grid.[x - 1, y]
    for tile in remaining do
        for right in tile.views do
            if left.edges.right = right.edges.left then
                yield right
}

let findPossibleTop(grid: tileGrid, x: int, y: int, remaining: tile seq) = seq {
    let top = grid.[x, y - 1]
    for tile in remaining do
        if tile.views.Length = 0 then
            if top.edges.bottom = tile.edges.top then
                yield tile
        else
            for bottom in tile.views do
                if top.edges.bottom = bottom.edges.top then
                    yield bottom
}

let findPossible(grid: tileGrid, x: int, y: int, remaining: tile list) =
    let mutable possible = remaining |> List.toSeq
    if x > 0 then
        possible <- findPossibleLeft(grid, x, y, possible)

    if y > 0 then
        possible <- findPossibleTop(grid, x, y, possible)

    possible |> Seq.toList

let rec solveGrid(grid: tileGrid, x: int, y: int, remaining: tile list) =
    if remaining.Length = 1 then
        let bottomRight = findPossible(grid, x + 1, y, remaining) |> Seq.item 0
        grid.[x + 1, y] <- bottomRight
        (true, grid)
    else
        let mutable x1 = x + 1
        let mutable y1 = y
        if x1 > grid.maxX then
            x1 <- 0
            y1 <- y1 + 1

        let mutable found = false
        let mutable result = grid
        let possibilities = findPossible(grid, x1, y1, remaining)

        let mutable i = 0
        while not(found) && i < possibilities.Length do
            let possible = possibilities.[i]

            let newGrid = grid.copy()
            newGrid.[x1, y1] <- possible

            let solved, output = solveGrid(newGrid, x1, y1, remove(remaining, possible))
            if solved then
                found <- true
                result <- output

            i <- i + 1

        (found, result)

let solveTile(tiles: tile list, topLeft: tile) =
    let size = int(sqrt(double(Seq.length tiles)))
    let grid = tileGrid(size)

    grid.clear()

    let mutable i = 0
    let mutable solved = false
    let mutable result = grid

    while not(solved) && i < topLeft.views.Length do
        grid.[0, 0] <- topLeft.views.[i]

        let gridSolved, grid = solveGrid(grid, 0, 0, remove(tiles, topLeft))
        if gridSolved then
            solved <- gridSolved
            result <- grid

        i <- i + 1

    solved, result

let getSum(grid: tileGrid) =
    let topLeft = grid.[0, 0]
    let topRight = grid.[grid.maxX, 0]
    let bottomLeft = grid.[0, grid.maxY]
    let bottomRight = grid.[grid.maxX, grid.maxY]

    topLeft.id * topRight.id * bottomLeft.id * bottomRight.id

let execute(inputs: input seq) =
    let tiles = createTiles inputs |> Seq.toList

    let mutable i = 0
    let mutable solved = false
    let mutable solution = tileGrid(0)
    while not(solved) && i < tiles.Length do
        let topLeft = tiles.[i]
        let tileSolved, result = solveTile(tiles, topLeft)
        if tileSolved then
            solved <- tileSolved
            solution <- result

        i <- i + 1

    (getSum(solution), solution)