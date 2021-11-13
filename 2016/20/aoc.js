module.exports = {
    firewallRules: function(input) {
        const ranges = []
        input.split('\n').forEach(line => {
            const info = line.trim().split('-')
            ranges.push([parseInt(info[0]), parseInt(info[1])])
        })

        let value = 0
        let range = [1]

        while (true) {
            range = ranges.filter(range => value >= range[0] && value <= range[1])
            if (range.length == 0) { break}
            value = range[0][1] + 1
        }

        return value
    }
}
