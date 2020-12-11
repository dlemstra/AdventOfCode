module Part1

open Input

type grid(width: int, height: int, ?data: char[]) =
    let grid = defaultArg data (Array.zeroCreate<char> (width * height))
    let mutable _changed = false
    member this.changed = _changed
    member this.maxX = width - 1
    member this.maxY = height - 1
    member this.Item
        with get(x, y) = grid.[(y * width) + x]
        and  set(x, y) value =
            grid.[(y * width) + x] <- value
            _changed <- true

    member this.copy() =
        new grid(width, height, Array.copy grid)

let printGrid(grid: grid) =
    for y = 0 to grid.maxY do
        for x = 0 to grid.maxX do
            printf "%c" grid.[y, x]
        printfn ""
    printfn ""

let createGrid(inputs: seq<input>) =
    let width = (Seq.item 0 inputs).line.Length
    let height = Seq.length inputs
    let grid = grid(width, height)
    let mutable y = 0
    for input in inputs do
        let mutable x = 0
        for char in input.line do
            grid.[x, y] <- char
            x <- x + 1
        y <- y + 1
    grid

let outsideGrid(grid: grid, x: int, y: int) =
    y < 0 || y > grid.maxY || x < 0 || x > grid.maxX

let isEmpty(grid: grid, x: int, y: int) =
    if outsideGrid(grid, x, y) then
        true
    else
        grid.[x, y] = '.' || grid.[x, y] = 'L'

let shouldFill(grid: grid, x: int, y: int) =
    isEmpty(grid, x - 1, y - 1) &&
    isEmpty(grid, x, y - 1) &&
    isEmpty(grid, x + 1, y - 1) &&
    isEmpty(grid, x - 1, y) &&
    isEmpty(grid, x + 1, y) &&
    isEmpty(grid, x - 1, y + 1) &&
    isEmpty(grid, x, y + 1) &&
    isEmpty(grid, x + 1, y + 1)

let isOccupied(grid: grid, x: int, y: int) =
    if outsideGrid(grid, x, y) then
        false
    else
        grid.[x, y] = '#'

let shouldEmpty(grid, x: int, y: int) =
    let mutable count = 0

    count <- count + if isOccupied(grid, x - 1, y - 1) then 1 else 0
    count <- count + if isOccupied(grid, x, y - 1) then 1 else 0
    count <- count + if isOccupied(grid, x + 1, y - 1) then 1 else 0
    count <- count + if isOccupied(grid, x - 1, y) then 1 else 0
    count <- count + if count < 4 && isOccupied(grid, x + 1, y) then 1 else 0
    count <- count + if count < 4 && isOccupied(grid, x - 1, y + 1) then 1 else 0
    count <- count + if count < 4 && isOccupied(grid, x, y + 1) then 1 else 0
    count <- count + if count < 4 && isOccupied(grid, x + 1, y + 1) then 1 else 0

    count = 4

let changeSeats(grid: grid) =
    let newGrid = grid.copy()
    for y = 0 to newGrid.maxY do
        for x = 0 to newGrid.maxX do
            let value = grid.[x, y]
            if value = 'L' && shouldFill(grid, x, y) then
                newGrid.[x, y] <- '#'
            elif value = '#' && shouldEmpty(grid, x, y) then
                newGrid.[x, y] <- 'L'
            else
                ()
    newGrid

let countOccupied(grid: grid) =
    let mutable occupied = 0
    for y = 0 to grid.maxY do
        for x = 0 to grid.maxX do
            occupied <- occupied + if isOccupied(grid, x, y) then 1 else 0
    occupied

let execute(inputs: seq<input>) =
    let mutable grid = createGrid inputs
    grid.[0, 0] <- grid.[0, 0]

    while grid.changed do
        grid <- changeSeats grid
        //printGrid grid

    countOccupied grid
