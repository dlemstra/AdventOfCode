module Part2

open Input
open System

[<AbstractClass>]
type instruction() =
    let mutable executionCount = 0

    member this.executed = executionCount > 0
    member this.execute(position, value) =
        executionCount <- executionCount + 1
        this.act(position, value)

    abstract member act: input:int * int -> int * int

type nop() =
    inherit instruction()

    override this.act(position, value) =
        (position + 1, value)

type acc(increment: string) =
    inherit instruction()

    let increment = Int32.Parse(increment)
    override this.act(position, value) =
        (position + 1, value + increment)

type jmp(increment: string) =
    inherit instruction()

    let increment = Int32.Parse(increment)
    override this.act(position, value) =
        (position + increment, value)

let createInstruction(instruction: string): instruction =
    let name = instruction.Substring(0, 3)
    let value = instruction.Substring(3)

    match name with
        | "nop" -> upcast nop()
        | "acc" -> upcast acc(value)
        | "jmp" -> upcast jmp(value)
        | _ -> failwithf "Unknown instruction"

let createInstructions(inputs: seq<string>) = seq {
    for input in inputs do
        let instruction = createInstruction(input)
        yield instruction
}

let rec executeInstructions(instructions: list<instruction>, position: int, value: int) =
    if position < 0 || position >= instructions.Length then
        (true, value)
    else
        let instruction = instructions.[position]
        if instruction.executed then
            (false, value)
        else
            let newPosition, newValue = instruction.execute(position, value)
            executeInstructions(instructions, newPosition, newValue)

let canBeChanged(input: input) =
    input.instruction.StartsWith("nop") || input.instruction.StartsWith("jmp")

let changeInput(inputs: seq<input>, position: int) = seq {
    for i = 0 to Seq.length inputs - 1 do
        let input = Seq.item i inputs
        let instruction = input.instruction
        if i = position && instruction.StartsWith("nop") then
            yield "jmp" + instruction.Substring(3)
        elif i = position && instruction.StartsWith("jmp") then
            yield "nop" + instruction.Substring(3)
        else
            yield instruction
}

let bruteForce(inputs: seq<input>) = seq {
    let count = Seq.length inputs
    for i = 0 to count - 1 do
        if canBeChanged(Seq.item i inputs) then
            let newInputs = changeInput(inputs, i)
            let instructions = List.ofSeq (createInstructions(newInputs))
            printf "\rPart2: %d%%" (int ((100.0 / double count) * (double i)))
            let passed, value = executeInstructions(instructions, 0, 0)
            if passed then
                printf "\r"
                yield value
}

let execute(inputs: seq<input>) =
    let result = bruteForce(inputs)
    let value = Seq.item 0 result

    value
