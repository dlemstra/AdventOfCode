function getMax(object) {
    let maxKey = 0
    let maxValue = 0
    for (key in object) {
        if (object[key] > maxValue) {
            maxKey = key
            maxValue = object[key]
        }
    }

    return maxKey
}

module.exports = {
    signalsAndNoise: function(input) {
        var frequency = {}

        input.split('\n').forEach(line => {
            for (let i=0; i < line.length; i++) {
                const char = line[i]
                if (!frequency[i]) { frequency[i] = {} }
                if (!frequency[i][char]) { frequency[i][char] = 0 }
                frequency[i][char]++
            }
        });

        let message = ''
        for (index in frequency) {
            message += getMax(frequency[index])
        }

        return message
    }
}
