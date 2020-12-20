module Part1

open Input
open System

type grid<'containedType>(width: int, height: int, ?data: 'containedType[]) =
    let mutable data = defaultArg data (Array.zeroCreate<'containedType> (width * height))
    member this.maxX = width - 1
    member this.maxY = height - 1

    member this.Item
        with get(x, y) = data.[(y * width) + x]
        and  set(x, y) value =
            data.[(y * width) + x] <- value

    member this.update(newData: 'containedType[]) =
        data <- newData

    member this.getData() =
        data

type edges(top: char[], right: char[], bottom: char[], left: char[]) =
    member this.top = top
    member this.right = right
    member this.bottom = bottom
    member this.left = left

type tile(id: int64, size: int, ?data: char[]) =
    inherit grid<char>(size, size, defaultArg data (Array.zeroCreate<char> (size * size)))

    let mutable _edges = edges(null, null, null, null)
    let mutable _views = Array.zeroCreate<tile> 0 |> Seq.toList

    member this.id = id
    member this.edges = _edges
    member this.views = _views

    static member empty() =
        tile(0L, 0)

    member this.setViews() =
        let mutable views = [this]

        let mutable tile = this
        views <- this.addView(views, tile.flipHorizontal())
        views <- this.addView(views, tile.flipVertical())
        for i = 0 to 3 do
            tile <- tile.rotate()
            views <- this.addView(views, tile)
            views <- this.addView(views, tile.flipHorizontal())
            views <- this.addView(views, tile.flipVertical())

        for tile in views do
            tile.setEdges()

        _views <- views

    member private this.addView(views: tile list, tile: tile) =
        let item = views |> Seq.tryFind (fun t -> t.getData() = tile.getData())
        if item.IsNone then
            views @ [tile]
        else
            views

    member private this.rotate() =
        let result = tile(id, size)

        for y = 0 to this.maxY do
            for x = 0 to this.maxX do
                result.[x, y] <- this.[y, this.maxX - x]

        result

    member private this.flipHorizontal() =
        let result = tile(id, size)

        for y = 0 to this.maxY do
            for x = 0 to this.maxX do
                result.[x, y] <- this.[this.maxX - x, y]

        result

    member private this.flipVertical() =
        let result = tile(id, size)

        for y = 0 to this.maxY do
            for x = 0 to this.maxX do
                result.[x, y] <- this.[x, this.maxY - y]

        result

    member private this.setEdges() =
        let top = Array.zeroCreate<char> size
        let right = Array.zeroCreate<char> size
        let bottom = Array.zeroCreate<char> size
        let left = Array.zeroCreate<char> size

        for y = 0 to this.maxY do
            for x = 0 to this.maxX do
                let value = this.[x, y]

                if y = 0 then top.[x] <- value
                if y = this.maxY then bottom.[x] <- value
                if x = 0 then left.[y] <- value
                if x = this.maxX then right.[y] <- value

        _edges <- edges(top, right, bottom, left)

type tileGrid(size: int, ?data: tile[]) =
    inherit grid<tile>(size, size, defaultArg data (Array.zeroCreate<tile> (size * size)))

    member this.copy() =
        let newData = Array.zeroCreate<tile> (size * size)
        for y = 0 to this.maxY do
            for x = 0 to this.maxX do
                newData.[(y * size) + x] <- base.[x, y]

        tileGrid(size, newData)

    member this.clear() =
        for y = 0 to this.maxY do
            for x = 0 to this.maxX do
                base.[y, x] <- tile.empty()

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

let printTile(tile: tile) =
    printfn "Tile: %d" tile.id
    for y in 0 .. tile.maxY do
        for x in 0 .. tile.maxX do
            printf "%c" tile.[x, y]
        printfn ""
    printfn ""

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
        grid.[x + 1, y] <- remaining.[0]
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

    let topLeft = result.[0, 0]
    let topRight = result.[result.maxX, 0]
    let bottomLeft = result.[0, result.maxY]
    let bottomRight = result.[result.maxX, result.maxY]

    solved, topLeft.id * topRight.id * bottomLeft.id * bottomRight.id

let execute(inputs: input seq) =
    let tiles = createTiles inputs |> Seq.toList

    let mutable i = 0
    let mutable solved = false
    let mutable solution = 0L
    while not(solved) && i < tiles.Length do
        let topLeft = tiles.[i]
        let tileSolved, result = solveTile(tiles, topLeft)
        if tileSolved then
            solved <- tileSolved
            solution <- result

        i <- i + 1

    solution