module Input

open System.IO

type input(directions: string) =
    member this.directions = directions

let read = seq {
    let lines = File.ReadAllLines("..\..\..\input")
    for line in lines do
        let mutable temp = line.Replace("se","SE,")
        temp <- temp.Replace("sw","SW,")
        temp <- temp.Replace("nw","NW,")
        temp <- temp.Replace("ne","NE,")
        temp <- temp.Replace("w","w,")
        temp <- temp.Replace("e","e,")
        yield input(temp.ToLowerInvariant().TrimEnd(','))
}
