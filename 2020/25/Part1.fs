module Part1

open Input

let encrypt(value: int64, subjectNumber: int64) =
    (value * subjectNumber) % 20201227L

let encryptionKey(subjectNumber: int64, loopCount: int) =
    let mutable value = encrypt(1L, subjectNumber)
    for i = 2 to loopCount do
        value <- encrypt(value, subjectNumber)
    value

let loopCount(publicKey: int64) =
    let subjectNumber = 7L
    let mutable value = encrypt(1L, subjectNumber)

    let mutable loopCount = 1
    while value <> publicKey do
        value <- encrypt(value, subjectNumber)
        loopCount <- loopCount + 1
    loopCount

let execute(inputs: input seq) =
    let key1 = (Seq.item 0 inputs).result
    let key2 = (Seq.item 1 inputs).result

    let key1Count = loopCount(key1)
    encryptionKey(key2, key1Count)