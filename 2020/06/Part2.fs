module Part2
open Input
open System.Collections.Generic

let sameAnswerCount(input: input) =
    let answers = new Dictionary<char, int>()
    for line in input.lines do
        for char in line.ToCharArray() do
            answers.[char] <- if answers.ContainsKey(char) then answers.[char] + 1 else 1

    let sameAnswers = answers.Keys |> Seq.filter (fun key -> answers.[key] = input.lines.Length)
    Seq.length sameAnswers

let execute(inputs: seq<input>) =
    let sameAnswersCount = inputs |> Seq.map (fun input -> sameAnswerCount input)
    Seq.sum sameAnswersCount
