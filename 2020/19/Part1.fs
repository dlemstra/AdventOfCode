module Part1

open Input
open System

type rule(char: char, subRules: int list list) =
    member this.char = char
    member this.subRules = subRules

let rec isValidRule(rules: rule[], rule: rule, message: string) =
    if rule.char <> '0' then
        (message.[0] = rule.char, 1)
    else
        let mutable matched = false

        let mutable offset = 0

        let mutable i = 0
        while not(matched) && i < rule.subRules.Length do
            let subRule = rule.subRules.[i]

            let mutable valid = true
            if subRule.Length > message.Length then
                valid <- false
            else
                offset <- 0
                let mutable j = 0
                while valid && j < subRule.Length do
                    let childRule = rules.[subRule.[j]]
                    let validRole, length = isValidRule(rules, childRule, message.Substring(offset))
                    if validRole then
                        offset <- offset + length
                    else
                        valid <- false
                    j <- j + 1
                if valid then
                    matched <- true

            i <- i + 1

        (matched, offset)

let createRules(patterns: string list) =
    let mutable result = Array.zeroCreate<rule> patterns.Length

    let mutable i = 0
    while i < patterns.Length do
        let pattern = patterns.[i]
        if not(pattern = null) then
            if pattern.[0] = '"' then
                result.[i] <- rule(pattern.[1], [])
            else
                let subRules = pattern.Split(" | ") |> (Seq.map (fun x -> x.Split(' ') |> Seq.map (fun x -> Int32.Parse x) |> Seq.toList)) |> Seq.toList
                result.[i] <- rule('0', subRules)
        i <- i + 1

    result

let execute(input: input) =
    let rules = createRules input.patterns

    let mutable valid = 0

    let firstRule = rules.[0]
    for message in input.messages do
        let validRule, length = isValidRule(rules, firstRule, message)
        if validRule && length = message.Length then
            valid <- valid + 1

    valid