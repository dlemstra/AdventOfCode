module Input

open System.IO

type input(characters: char[]) =
    member this.characters = characters

let read = seq {
    let lines = File.ReadAllLines("..\..\..\input")

    for line in lines do
        yield input(line.ToCharArray())
}