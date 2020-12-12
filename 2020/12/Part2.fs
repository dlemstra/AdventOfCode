module Part2

open Input
open System

type direction = North | East | South | West

type position(x: int, y: int) =
    member val x = x with get, set
    member val y = y with get, set

    member this.move(direction: direction, steps: int) =
        match direction with
            | North -> this.y <- this.y - steps
            | East -> this.x <- this.x + steps
            | South -> this.y <- this.y + steps
            | West -> this.x <- this.x - steps

    member this.move(other: position, times: int) =
        this.x <- this.x + (other.x * times)
        this.y <- this.y + (other.y * times)

    member this.rotate(degrees: int) =
        let currentX = this.x
        let currentY = this.y
        match degrees with
            | 90 ->
                this.x <- -currentY
                this.y <- currentX
            | 180 -> 
                this.x <- -currentX
                this.y <- -currentY
            | 270 ->
                this.x <- currentY
                this.y <- -currentX
            | _ -> failwithf "Unknown direction"

let execute(inputs: seq<input>) =
    let ship = position(0, 0)
    let waypoint = position(10, -1)

    for input in inputs do
        let action = input.instruction.[0]
        let value = Int32.Parse(input.instruction.Substring(1))

        match action with
            | 'N' -> waypoint.move(North, value)
            | 'E' -> waypoint.move(East, value)
            | 'S' -> waypoint.move(South, value)
            | 'W' -> waypoint.move(West, value)
            | 'L' -> waypoint.rotate(360 - value)
            | 'R' -> waypoint.rotate(value)
            | 'F' -> ship.move(waypoint, value)
            | _ -> failwithf "Unknown instruction"

    (abs ship.x) + (abs ship.y)