const directions = {
    North: 0,
    East: 1,
    South: 2,
    West: 3,
}

const distance = (x, y) => Math.abs(x) + Math.abs(y)

module.exports = {
    noTimeForATaxicab: function(input) {
        const set = new Set()
        let part2 = 0
        let direction = directions.North
        let x = 0
        let y = 0
        const instructions = input.split(', ')
        instructions.forEach(instruction => {
            switch(instruction[0]) {
                case 'R':
                    direction += 1;
                    break;
                case 'L':
                    direction -= 1;
                    break;
            }

            if (direction == -1) { direction = directions.West }
            if (direction == 4) { direction = directions.North }

            let blocks = parseInt(instruction.substring(1))

            while (blocks-- > 0) {
                let pos = `${x}.${y}`
                if (!set.has(pos)) {
                    set.add(pos)
                } else if (part2 == 0) {
                    part2 = distance(x, y)
                }

                switch(direction) {
                    case directions.North:
                        y += 1;
                        break;
                    case directions.East:
                        x += 1;
                        break;
                    case directions.South:
                        y -= 1;
                        break;
                    case directions.West:
                        x -= 1;
                        break;
                }
            }
        })

        return [distance(x, y), part2];
    }
}
