class Disc {
    constructor(position, length) {
        this.position = position
        this.length = length
    }

    takeStep() {
        this.position = (this.position + 1) % this.length
    }
}

function isDone(discs) {
    const position = discs[0].position
    for (let i=1; i < discs.length; i++) {
        if (discs[i].position != position) { return false }
    }

    return true
}

module.exports = {
    timingIsEverything: function(input) {
        const discs = []

        input.split('\n').forEach(line => {
            const info = line.replace('.', '').split(' ')
            const position = parseInt(info[11])
            const length = parseInt(info[3])
            discs.push(new Disc(position, length))
        });

        for (let i=0; i < discs.length; i++) {
            for (let j=0; j < i; j++) {
                discs[i].takeStep()
            }
        }

        let time = 0
        while (!isDone(discs)) {
            for (let i=0; i < discs.length; i++) {
                discs[i].takeStep()
            }
            time++
        }

        return time - 1
    }
}
