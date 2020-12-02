module Part1

let execute(numbers) = seq {
    for i = 0 to Seq.length numbers - 1 do
        let a = Seq.item i numbers
        let others = Seq.filter (fun x -> x <> a && a + x = 2020) numbers
        if not (Seq.isEmpty others) then
            let b = Seq.item 0 others
            yield a * b
}