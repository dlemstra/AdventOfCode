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

module.exports = {
    securityThroughObscurity: function(input) {
        let sum = 0

        input.split('\n').forEach((line) => {
            let chars = line.trim().split('-')
            const last = chars.pop().split('[')
            chars = chars.join('').split('')
            chars = sortByFrequency(chars)

            const name = last[1].slice(0, -1)
            if (name == chars.slice(0, 5).join('')) {
                const sectorId = parseInt(last[0])
                sum += sectorId
            }
        })

        return sum
    }
}
