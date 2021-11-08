const directions = {
    North: 0,
    East: 1,
    South: 2,
    West: 3,
}

module.exports = {
    noTimeForATaxicab: function(input) {
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

            switch(direction) {
                case directions.North:
                    y += blocks;
                    break;
                case directions.East:
                    x += blocks;
                    break;
                case directions.South:
                    y -= blocks;
                    break;
                case directions.West:
                    x -= blocks;
                    break;
            }
        })

        return Math.abs(x) + Math.abs(y);
    }
}
