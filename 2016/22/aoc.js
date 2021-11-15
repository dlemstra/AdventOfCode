class Node {
    constructor(name, size, used, avail) {
        const info = name.split('-')
        this.x = parseInt(info[1].substring(1))
        this.y = parseInt(info[2].substring(1))
        this.size = this.parseSize(size)
        this.used = this.parseSize(used)
        this.avail = this.parseSize(avail)
    }

    parseSize(value) { return parseInt(value.substring(0, value.length - 1)) }
}

function combinations(n, k) {
    let result = [];

    function recurse(start, combos) {
        if (combos.length === k) {
            return result.push(combos.slice());
        }

        if (combos.length + (n - start + 1) < k){
            return;
        }

        recurse(start + 1, combos);
        combos.push(start);
        recurse(start + 1, combos);
        combos.pop();
    }

    recurse(0, []);
    return result;
}

function isViablePair(nodeA, nodeB) {
    if (nodeA.used == 0) { return false }
    return nodeA.used < nodeB.avail
}

class State {
    constructor(node) {
        this.x = node.x
        this.y = node.y
        this.used = node.used,
        this.distance = Number.MAX_VALUE,
        this.previous = null
    }
}

class Position {
    constructor(x, y) {
        this.x = x
        this.y = y
    }

    same(other) { return other && this.x == other.x && this.y == other.y }
}

function findPath(nodes, start, end, noGo) {
    const states = {}

    nodes.forEach(node => {
        states[`${node.x}x${node.y}`] = new State(node)
    })

    states[`${start.x}x${start.y}`].distance = 0

    const positions = []
    positions.push(start)

    while (positions.length > 0) {
        const position = positions.pop()
        const current = states[`${position.x}x${position.y}`]

        const newPositions = [
            new Position(position.x + 1, position.y + 0),
            new Position(position.x - 1, position.y + 0),
            new Position(position.x + 0, position.y + 1),
            new Position(position.x + 0, position.y - 1)
        ]
        for (let i=0; i < newPositions.length; i++) {
            const newPosition = newPositions[i]
            if (newPosition.same(end)) {
                let steps = [newPosition]
                let previous = current
                while (previous.previous) {
                    steps.push(new Position(previous.x, previous.y))
                    previous = states[`${previous.previous.x}x${previous.previous.y}`]
                }

                return steps
            }

            if (newPosition.same(noGo)) { continue }

            const state = states[`${newPosition.x}x${newPosition.y}`]
            if (!state || state.used > 100) { continue }

            if (state.distance > current.distance + 1) {
                state.distance = current.distance + 1
                state.previous = position
                positions.splice(0, 0, newPosition)
            }
        }
    }

    return null
}

module.exports = {
    gridComputing: function(input) {
        const nodes = []

        input.split('\n').forEach(line => {
            if (line[0] == '/') {
                const info = line.trim().split(' ').filter(x => x != '')
                const node = new Node(info[0], info[1], info[2], info[3])
                nodes.push(node)
            }
        })

        let part1 = 0
        const indexes = combinations(nodes.length - 1, 2)
        for (let i=0; i < indexes.length; i++) {
            const nodeA = nodes[indexes[i][0]]
            const nodeB = nodes[indexes[i][1]]
            if (isViablePair(nodeA, nodeB) || isViablePair(nodeB, nodeA)) { part1++ }
        }

        const width = Math.max.apply(null, nodes.map(node => node.y == 0 ? node.x : 0))
        const emptyNode = nodes.filter(node => node.used == 0)[0]

        const start = new Position(0, 0)
        let goal = new Position(width, 0)
        let empty =  new Position(emptyNode.x, emptyNode.y)

        const steps = findPath(nodes, goal, start)

        let part2 = 0
        while (steps.length > 0) {
            const end = steps.pop()
            const subSteps = findPath(nodes, empty, end, goal)
            part2 += subSteps.length + 1
            empty = goal
            goal = subSteps[0]
        }

        return [part1, part2]
    }
}
