class Bot {
    constructor(nr) {
        this.nr = nr
        this.values = []
        this.low = [-1, -1]
        this.high = [-1, -1]
    }

    addValue(value) {
        this.values.push(value)
        this.values.sort((a, b) => a - b)
    }
}

function findBot(bots, nr) {
    let bot = bots.filter(b => b.nr == nr)[0]
    if (!bot) {
        bot = new Bot(nr)
        bots.push(bot)
    }

    return bot
}

module.exports = {
    balanceBots: function(input, valueLow, valueHigh, outputs) {
        const bots = []
        let lines = input.split('\n')
        lines.forEach(line => {
            const info = line.trim().split(' ')
            if (line[0] == 'v') { // value
                const nr = parseInt(info[5])
                const bot = findBot(bots, nr)
                bot.addValue(parseInt(info[1]))
            } else { // bot
                const nr = parseInt(info[1])
                const bot = findBot(bots, nr)
                const targetLow = parseInt(info[6]);
                if (info[5] == 'bot') { bot.low[0] = targetLow } else { bot.low[1] = targetLow }
                const targetHigh = parseInt(info[11])
                if (info[10] == 'bot') { bot.high[0] = targetHigh } else { bot.high[1] = targetHigh }
            }
        });

        let part1 = -1
        let part2 = 1
        while (bots.length > 0) {
            for (i=0; i < bots.length; i++) {
                const bot = bots[i]
                if (bot.values.length == 2) {
                    bots.splice(i, 1)

                    const high = bot.values.pop()
                    if (bot.high[0] != -1) {
                        let highBot = findBot(bots, bot.high[0])
                        highBot.addValue(high)
                    } else if (outputs.includes(bot.high[1])) {
                        part2 *= high
                    }

                    const low = bot.values.pop()
                    if (bot.low[0] != -1) {
                        let lowBot = findBot(bots, bot.low[0])
                        lowBot.addValue(low)
                    } else if (outputs.includes(bot.low[1])) {
                        part2 *= low
                    }

                    if (low == valueLow && high == valueHigh) {
                        part1 = bot.nr
                    }
                }
            }
        }

        return [part1, part2]
    }
}
