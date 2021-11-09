function isValid(line) {
    let valid = 0
    let insideBrackets = false
    for (let i=0; i < line.length-4; i++) {
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

module.exports = {
    internetProtocolVersion7: function(input) {
        const items = input.split('\n').map(line => isValid(line));

        return items.reduce((partial_sum, value) => partial_sum + value, 0);
    }
}
