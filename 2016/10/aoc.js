class Bot {
    constructor(nr) {
        this.nr = nr
        this.values = []
        this.low_target = -1
        this.high_target = -1
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
    balanceBots: function(input, valueLow, valueHigh) {
        const bots = []
        let lines = input.split('\n')
        lines.forEach(line => {
            const info = line.trim().split(' ')
            if (line[0] == 'v') { // value
                const nr = parseInt(info[5])
                let bot = findBot(bots, nr)
                bot.addValue(parseInt(info[1]))
            } else { // bot
                const nr = parseInt(info[1])
                let bot = findBot(bots, nr)
                if (info[5] == 'bot') {
                    bot.low_target = parseInt(info[6])
                }
                if (info[10] == 'bot') {
                    bot.high_target = parseInt(info[11])
                }
            }
        });

        let part1 = -1
        while (bots.length > 0) {
            for (i=0; i < bots.length; i++) {
                const bot = bots[i]
                if (bot.values.length == 2) {
                    bots.splice(i, 1)

                    const high = bot.values.pop()
                    if (bot.high_target != -1) {
                        let highBot = findBot(bots, bot.high_target)
                        highBot.addValue(high)
                    }

                    const low = bot.values.pop()
                    if (bot.low_target != -1) {
                        let lowBot = findBot(bots, bot.low_target)
                        lowBot.addValue(low)
                    }

                    if (low == valueLow && high == valueHigh) {
                        part1 = bot.nr
                    }
                }
            }
        }

        return part1
    }
}
