module Part1

open Input
open System.Collections.Generic

let possibleWords(inputs: seq<input>, allergens: string seq) =
    let words = Dictionary<string, string list>()

    for allergen in allergens do
        let sentences = inputs |> Seq.filter (fun input -> Seq.contains allergen input.allergens) |> Seq.toList

        let mutable found = sentences.[0].words
        for input in Seq.skip 1 sentences do
            found <- (input.words |> Seq.where (fun word -> (Seq.contains word found))) |> Seq.toList

        words.Add(allergen, found)
    words

let getTranslations(words: Dictionary<string, string list>) = 
    let translations = Dictionary<string, string>()

    while words.Count > 0 do
        let singleWords = words |> Seq.where (fun keyValue -> keyValue.Value.Length = 1)
        for singleWord in singleWords do
            let translation = Seq.item 0 singleWord.Value
            translations.[singleWord.Key] <- translation

            for other in (words |> Seq.where (fun keyValue -> Seq.contains translation keyValue.Value)) do
                words.[other.Key] <- (other.Value |> Seq.filter (fun w -> w <> translation) |> Seq.toList)

            words.Remove(singleWord.Key) |> ignore

    translations

let execute(inputs: seq<input>) =
    let allergens = (List.concat (inputs |> Seq.map (fun input -> input.allergens))) |> Seq.distinct

    let words = possibleWords(inputs, allergens)
    let translations = getTranslations(words)

    let mutable total = 0

    let translatedWords = translations.Values
    for input in inputs do
        let notTranslated = input.words |> Seq.filter (fun word -> not(Seq.contains word translatedWords))
        total <- total + Seq.length notTranslated

    total