module.exports = {
    firewallRules: function(input) {
        const ranges = []
        input.split('\n').forEach(line => {
            const info = line.trim().split('-')
            ranges.push([parseInt(info[0]), parseInt(info[1])])
        })

        let part1 = -1
        let part2 = 0

        let value = 0
        let range = [1]

        while (value < 4294967295) {
            range = ranges.filter(range => value >= range[0] && value <= range[1])
            if (range.length == 0) {
                if (part1 == -1) { part1 = value }
                part2++
                value = value + 1
            } else {
                value = range[0][1] + 1
            }
        }

        return [part1, part2]
    }
}
