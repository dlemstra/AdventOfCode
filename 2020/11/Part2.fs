module Part2

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

let canSeeOccupied(grid: grid, startX: int, startY: int, xDelta: int, yDelta: int) =
    let mutable foundOccupied = false
    let mutable x = startX + xDelta
    let mutable y = startY + yDelta
    while not (foundOccupied || outsideGrid(grid, x, y)) do
        if grid.[x, y] = '#' then
            foundOccupied <- true
        elif grid.[x, y] = 'L' then
            x <- -1
            y <- -1
        else
            x <- x + xDelta;
            y <- y + yDelta;
    foundOccupied

let shouldFill(grid: grid, x: int, y: int) =
    not (
        canSeeOccupied(grid, x, y, -1, -1) ||
        canSeeOccupied(grid, x, y, 0,  - 1) ||
        canSeeOccupied(grid, x, y, 1, -1) ||
        canSeeOccupied(grid, x, y, -1, 0) ||
        canSeeOccupied(grid, x, y, 1, 0) ||
        canSeeOccupied(grid, x, y, -1, 1) ||
        canSeeOccupied(grid, x, y, 0, 1) ||
        canSeeOccupied(grid, x, y, 1, 1)
    )

let shouldEmpty(grid: grid, x: int, y: int) =
    let mutable count = 0

    count <- count + if canSeeOccupied(grid, x, y, -1, -1) then 1 else 0
    count <- count + if canSeeOccupied(grid, x, y, 0,  - 1) then 1 else 0
    count <- count + if canSeeOccupied(grid, x, y, 1, -1) then 1 else 0
    count <- count + if canSeeOccupied(grid, x, y, -1, 0) then 1 else 0
    count <- count + if canSeeOccupied(grid, x, y, 1, 0) then 1 else 0
    count <- count + if count < 5 && canSeeOccupied(grid, x, y, -1, 1) then 1 else 0
    count <- count + if count < 5 && canSeeOccupied(grid, x, y, 0, 1) then 1 else 0
    count <- count + if count < 5 && canSeeOccupied(grid, x, y, 1, 1) then 1 else 0

    count = 5

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
            occupied <- occupied + if grid.[x, y] = '#' then 1 else 0
    occupied

let execute(inputs: seq<input>) =
    let mutable grid = createGrid inputs
    grid.[0, 0] <- grid.[0, 0]

    while grid.changed do
        grid <- changeSeats grid
        // printGrid grid

    countOccupied grid
