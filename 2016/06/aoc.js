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

function getMin(object) {
    let minKey = 0
    let minValue = 100000
    for (key in object) {
        if (object[key] < minValue) {
            minKey = key
            minValue = object[key]
        }
    }

    return minKey
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

        let message1 = ''
        let message2 = ''
        for (index in frequency) {
            message1 += getMax(frequency[index])
            message2 += getMin(frequency[index])
        }

        return [message1 , message2]
    }
}
