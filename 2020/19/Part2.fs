module Part2

open Input
open System
open System.Collections.Generic

type state = Unknown | Valid | Invalid

type rule(char: char, subRules: int list list) =
    member this.char = char
    member this.subRules = subRules
    member this.minLength = max subRules.Length 1

let replaceCurrentRule(rules: rule[], currentRules: rule list, subRule: int list, ruleIndex: int) = seq {
    for i = 0 to currentRules.Length - 1 do
        if i = ruleIndex then
            for subRuleIndex in subRule do
                yield rules.[subRuleIndex]
        else
            yield currentRules.[i]
}

let rec isValidRule(rules: rule[], message: string) =
    let stack = new Stack<rule list>()

    stack.Push([rules.[0]])

    let mutable status = Unknown

    while status <> Valid && stack.Count > 0 do
        let currentRules = stack.Pop()

        status <- Unknown

        let mutable position = 0
        let mutable i = 0
        while status = Unknown && i < currentRules.Length do
            let rule = currentRules.[i]
            if rule.char = message.[position] then
                position <- position + 1
                if i = currentRules.Length - 1 then
                    if position = message.Length then
                        status <- Valid
            else
                if rule.char = '0' then
                    for subRule in rule.subRules do
                        let newRules = replaceCurrentRule(rules, currentRules, subRule, i) |> Seq.toList
                        if newRules.Length <= message.Length then
                            stack.Push(newRules)
                status <- Invalid
            i <- i + 1
    status = Valid

let createRules(patterns: string list) =
    let mutable result = Array.zeroCreate<rule> patterns.Length

    let mutable i = 0
    while i < patterns.Length do
        let mutable pattern = patterns.[i]
        if not(pattern = null) then
            if pattern.[0] = '"' then
                result.[i] <- rule(pattern.[1], [])
            else
                if i = 8 then
                    pattern <- "42 | 42 8"
                elif i = 11 then
                    pattern <- "42 31 | 42 11 31"
                let subRules = pattern.Split(" | ") |> (Seq.map (fun x -> x.Split(' ') |> Seq.map (fun x -> Int32.Parse x) |> Seq.toList)) |> Seq.toList
                result.[i] <- rule('0', subRules)
        i <- i + 1

    result

let execute(input: input) =
    let rules = createRules input.patterns

    let mutable valid = 0

    let firstRule = rules.[0]
    for message in input.messages do
        if isValidRule(rules, message) then
            valid <- valid + 1

    valid
