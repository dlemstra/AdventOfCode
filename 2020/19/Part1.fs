module Part1

open Input
open System

type rule(char: char, subRules: int list list, ?length: int) =
    member this.char = char
    member this.subRules = subRules
    member this.length = defaultArg length 0
    member this.validFor(value: string) =
        value.Length = this.length

let rec isValidRule(rules: rule[], rule: rule, message: string) =
    if rule.char <> '0' then
        message.[0] = rule.char
    else
        let mutable matched = false

        let mutable i = 0
        while (not matched) && i < rule.subRules.Length do
            let subRule = rule.subRules.[i]
            let mutable valid = true
            if subRule.Length > message.Length then
                valid <- false
            else
                let mutable offset = 0
                let mutable j = 0
                while valid && j < subRule.Length do
                    let childRule = rules.[subRule.[j]]
                    if isValidRule(rules, childRule, message.Substring(offset)) then
                        offset <- offset + childRule.length
                    else
                        valid <- false
                    j <- j + 1
            if valid then
                matched <- true
            i <- i + 1

        matched

let rec getLength(rules: rule[], rule: rule) =
    if rule.char <> '0' then
        1
    else
        let mutable size = 0
        for index in rule.subRules.[0] do
            size <- + size + getLength(rules, rules.[index])
        size

let createRules(patterns: list<string>) =
    let mutable result = Array.zeroCreate<rule> patterns.Length

    let mutable i = 0
    while i < patterns.Length do
        let pattern = patterns.[i]
        if pattern.[0] = '"' then
            result.[i] <- rule(pattern.[1], [])
        else
            let subRules = pattern.Split(" | ") |> (Seq.map (fun x -> x.Split(' ') |> Seq.map (fun x -> Int32.Parse x) |> Seq.toList)) |> Seq.toList
            result.[i] <- rule('0', subRules)
        i <- i + 1

    i <- 0
    while i < result.Length do
        result.[i] <- rule(result.[i].char, result.[i].subRules, getLength(result, result.[i]))
        i <- i + 1

    result

let execute(input: input) =

    let rules = createRules input.patterns

    let mutable valid = 0

    let firstRule = rules.[0]
    for message in input.messages do
        if firstRule.validFor(message) && isValidRule(rules, firstRule, message) then
            valid <- valid + 1

    valid