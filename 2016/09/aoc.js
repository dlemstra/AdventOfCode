function calulateLength(input, start_index, length) {
    let part1 = 0
    let part2 = 0
    let start = -1
    for (let i=start_index; i < length; i++) {
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
                    part1 += times * (end - i - 1)

                    for (let j=0; j < times; j++) {
                        let [_, child_part2] =  calulateLength(input, i + 1, end)
                        part2 += child_part2
                    }
                }
                i += count
                start = -1
                break;
            default:
                if (start == -1) {
                    part1++
                    part2++
                }
                break
        }
    }

    return [part1, part2]
}

module.exports = {
    explosivesInCyberspace: function(input) {
        let total_part1 = 0;
        let total_part2 = 0;
        input.split('\n').forEach(line => {
            let [part1, part2] = calulateLength(line, 0, line.length)
            total_part1 += part1
            total_part2 += part2
        });

        return [total_part1, total_part2]
    }
}
