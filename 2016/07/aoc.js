function supportTLS(line) {
    let valid = 0
    let insideBrackets = false
    for (let i=0; i < line.length-3; i++) {
        if (line[i] == '[') { insideBrackets = true }
        if (line[i] == ']') { insideBrackets = false }

        if (line[i + 0] != line[i + 1] &&
            line[i + 0] == line[i + 3] &&
            line[i + 1] == line[i + 2])
        {
            if (insideBrackets) { return 0; }
            valid = 1
        }
    }

    return valid
}

function supportSSL(line) {
    let found_inside = []
    let found_outside = []

    let insideBrackets = false
    for (let i=0; i < line.length-2; i++) {
        if (line[i] == '[') { insideBrackets = true }
        if (line[i] == ']') { insideBrackets = false }

        if (line[i + 0] != line[i + 1] &&
            line[i + 1] != '[' &&
            line[i + 1] != ']' &&
            line[i + 0] == line[i + 2])
        {
            const value = line.slice(i, i + 3)
            if (insideBrackets) { found_inside.push(value) }
            else { found_outside.push(value) }
        }
    }

    let valid = 0
    found_inside.forEach(value => {
        const expected = `${value[1]}${value[0]}${value[1]}`
        if (found_outside.includes(expected)) { valid = 1 }
    });

    return valid
}

module.exports = {
    internetProtocolVersion7: function(input) {
        const items1 = input.split('\n').map(line => supportTLS(line));
        const items2 = input.split('\n').map(line => supportSSL(line));

        const part1 = items1.reduce((partial_sum, value) => partial_sum + value, 0);
        const part2 = items2.reduce((partial_sum, value) => partial_sum + value, 0);

        return [ part1, part2 ]
    }
}
