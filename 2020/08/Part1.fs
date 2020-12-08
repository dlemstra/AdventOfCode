module Part1

open Input
open System
open System.Collections.Generic

type IInstruction =
    abstract member execute: input:int * int -> int * int

type nop() = 
    interface IInstruction with
        member this.execute(position, value) =
            (position + 1, value)

type acc(increment: string) =
    member this.increment = Int32.Parse(increment)
    interface IInstruction with
        member this.execute(position, value) =
            (position + 1, value + this.increment)

type jmp(increment: string) =
    member this.increment = Int32.Parse(increment)
    interface IInstruction with
        member this.execute(position, value) =
            (position + this.increment, value)

let createInstruction(instruction: string): IInstruction =
    let name = instruction.Substring(0, 3)
    let value = instruction.Substring(3)

    match name with
        | "nop" -> new nop() :> IInstruction
        | "acc" -> new acc(value) :> IInstruction
        | "jmp" -> new jmp(value) :> IInstruction
        | _ -> failwithf "Unknown instruction"

let createInstructions(inputs: seq<input>) =
    let result = new Dictionary<int, IInstruction>()

    for i in 0 .. (Seq.length inputs) - 1 do
        let instruction = createInstruction((Seq.item i inputs).instruction)
        result.Add(i, instruction)

    result

let rec executeInstructions(instructions: Dictionary<int, IInstruction>, position: int, value: int) =
    if instructions.ContainsKey(position) then
        let instruction = instructions.[position]
        instructions.Remove(position) |> ignore
        let newPosition, newValue = instruction.execute(position, value)
        executeInstructions(instructions, newPosition, newValue)
    else
        value


let execute(inputs: seq<input>) =

    let instructions = createInstructions(inputs)

    executeInstructions(instructions, 0, 0)