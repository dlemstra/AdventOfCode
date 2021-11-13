module.exports = {
    anElephantNamedJoseph: function(input) {
        const count = parseInt(input)
        const circle = Array(count).fill(1)

        let index = 0
        while (true) {
            let next = (index + 1) % count
            while (circle[next] == 0 ) {
                next = (next + 1) % count
            }

            if (next == index) { return index + 1 }
            circle[index] += circle[next]
            circle[next] = 0

            index = (index + 1) % count
            while (circle[index] == 0 ) {
                index = (index + 1) % count
            }
        }

        return -1
    }
}
