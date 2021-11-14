function combinations(n, k) {
    let result= [];

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

class Node {
    constructor(name, size, used, avail) {
        this.name = name
        this.size = this.parseSize(size)
        this.used = this.parseSize(used)
        this.avail = this.parseSize(avail)
    }

    parseSize(value) { return parseInt(value.substring(0, value.length - 1)) }
}

function isViablePair(nodeA, nodeB) {
    if (nodeA.used == 0) { return false }
    return nodeA.used < nodeB.avail
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

        return part1
    }
}
