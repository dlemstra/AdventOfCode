function calulateLength(input) {
    let length = 0
    let start = -1
    for (let i=0; i < input.length; i++) {
        switch(input[i]) {
            case '(':
                start = i
                break;
            case ')':
                const info = input.substring(start + 1, i).split('x')
                const count = parseInt(info[0])
                const times = parseInt(info[1])
                const end = Math.min(i + 1 + count, input.length)
                if (i + 1 != end) {
                    length += times * (end - i - 1)
                }
                i += count
                start = -1
                break;
            default:
                if (start == -1) { length++ }
                break
        }
    }

    return length
}

module.exports = {
    explosivesInCyberspace: function(input) {
        return input.split('\n').map(line => calulateLength(line)).reduce((partial_sum, value) => partial_sum + value, 0)
    }
}
