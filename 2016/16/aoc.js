function createChecksum(data) {
    let checksum = []
    for (let i = 0; i < data.length; i+=2) {
        if (data[i] == data[i + 1]) { checksum.push(1) }
        else { checksum.push(0) }
    }

    return checksum
}

module.exports = {
    dragonChecksum: function(input, length) {
        let a = input.split('').map(c => parseInt(c))
        while (a.length < length) {
            const b = [...a].reverse().map(x => (x + 1) % 2)
            a = a.concat([0]).concat(b)
        }

        let c = createChecksum(a.slice(0, length))
        while (c.length % 2 == 0) {
            c = createChecksum(c)
        }

        return c.join('')
    }
}
