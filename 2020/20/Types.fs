module Types

type grid<'containedType>(width: int, height: int, ?data: 'containedType[]) =
    let mutable data = defaultArg data (Array.zeroCreate<'containedType> (width * height))
    member this.width = width
    member this.height = height
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

let printTile(tile: tile) =
    printfn "Tile: %d" tile.id
    for y in 0 .. tile.maxY do
        for x in 0 .. tile.maxX do
            printf "%c" tile.[x, y]
        printfn ""
    printfn ""