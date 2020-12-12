module Part1

open Input
open System

type direction = North | East | South | West

type ship() =
    let mutable x = 0
    let mutable y = 0
    member this.position = (x, y)
    member val direction = East with get, set
    member this.move(steps: int, ?direction: direction) =
        match defaultArg direction this.direction with
            | North -> y <- y - steps
            | East -> x <- x + steps
            | South -> y <- y + steps
            | West -> x <- x - steps
    member this.rotate(degrees: int) =
        let currentAngle = 
            match this.direction with
            | North -> 0
            | East -> 90
            | South -> 180
            | West -> 270
        this.direction <-
            match (currentAngle + degrees) % 360 with
            | 0 ->  North
            | 90 -> East
            | 180 -> South
            | 270 -> West
            | _ -> failwithf "Unknown direction"


let execute(inputs: seq<input>) =
    let ship = ship()

    for input in inputs do
        let action = input.instruction.[0]
        let value = Int32.Parse(input.instruction.Substring(1))

        match action with
            | 'N' -> ship.move(value, North)
            | 'E' -> ship.move(value, East)
            | 'S' -> ship.move(value, South)
            | 'W' -> ship.move(value, West)
            | 'L' -> ship.rotate(360 - value)
            | 'R' -> ship.rotate(value)
            | 'F' -> ship.move(value)
            | _ -> failwithf "Unknown instruction"

    let x, y = ship.position
    (abs x) + (abs y)

