function sortByFrequency(array) {
    var frequency = {}

    array.forEach(function(value) { frequency[value] = 0 })

    var uniques = array.filter(function(value) {
        return ++frequency[value] == 1
    });

    return uniques.sort(function(a, b) {
        const result = frequency[b] - frequency[a]
        if (result == 0) {
            if (a < b) { return -1 }
            if (b > a) { return 1 }
        }
        return result
    });
}

function decode(encoded, count) {
    const input  = 'abcdefghijklmnopqrstuvwxyz'
    const output = 'bcdefghijklmnopqrstuvwxyza'

    let decoded = encoded.split('')

    while (count-- > 0) {
        for (let i=0; i < decoded.length; i++) {
            const index = input.indexOf(decoded[i])
            decoded[i] = output[index]
        }
    }

    return decoded.join('');
}

module.exports = {
    securityThroughObscurity: function(input) {
        let sum = 0
        let northPoleObjectsSectorId = 0

        input.split('\n').forEach((line) => {
            const words = line.trim().split('-')
            const last = words.pop().split('[')
            let chars = words.join('').split('')
            chars = sortByFrequency(chars)

            const name = last[1].slice(0, -1)
            const sectorId = parseInt(last[0])
            if (name == chars.slice(0, 5).join('')) {
                sum += sectorId
            }

            let count = sectorId % 26
            const roomName = `${decode(words[0], count)} ${decode(words[1], count)} ${decode(words[2], count)}`
            if (roomName == 'northpole object storage') {
                northPoleObjectsSectorId = sectorId
            }
        })

        return [sum, northPoleObjectsSectorId]
    }
}
