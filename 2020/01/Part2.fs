module Part2

let execute(numbers) = seq {
    for i = 0 to Seq.length numbers - 1 do
        let a = Seq.item i numbers
        let itemsJ = Seq.filter (fun x -> x <> a && a + x < 2020) numbers
        for j in 0 .. Seq.length itemsJ - 1 do
            let b = Seq.item j itemsJ
            let itemsK = Seq.filter (fun x -> x <> b && b + x = 2020) numbers
            if not (Seq.isEmpty itemsK) then
                let c = Seq.item 0 itemsK
                yield a * b * c
}