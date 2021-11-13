function LinkedList() {
    this.Node = null;
    this.head = null;
};

LinkedList.prototype.append = function(value) {
    var node = {
        value: value,
        next: this.head
    };

    if (this.head === null) {
        this.head = {};
        this.head.value = value;
        this.head.next = this.head;
        this.tail = this.head;
    } else {
        this.tail.next = node;
        this.tail = node;
    }

    return node
};

module.exports = {
    anElephantNamedJoseph: function(input) {
        const count = parseInt(input)

        let linkedList = new LinkedList()
        for (let i=1; i <= count; i++) {
            linkedList.append(i)
        }

        let node = linkedList.head
        while (node.next != node) {
            node.next = node.next.next
            node = node.next
        }

        const part1 = node.value

        let mid = null
        let midIndex = Math.floor(count / 2)
        linkedList = new LinkedList()
        for (let i=1; i <= count; i++) {
            const node = linkedList.append(i)
            if (i == midIndex) { mid = node }
        }

        node = linkedList.head
        let remaining = count
        while (node.next != node) {
            mid.next = mid.next.next
            if (--remaining % 2 == 0) { mid = mid.next }
            node = node.next
        }

        const part2 = node.value

        return [part1, part2]
    }
}
