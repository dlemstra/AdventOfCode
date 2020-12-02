module Input

type input(min: int, max: int, char: char, password: string) =
    member this.min = min
    member this.max = max
    member this.char = char
    member this.password = password