module Part2

open System.Collections.Generic

let execute(translations: Dictionary<string, string>) =
    translations |> Seq.sortBy (fun keyValue -> keyValue.Key) |> Seq.map (fun keyValue -> keyValue.Value) |> String.concat ","
