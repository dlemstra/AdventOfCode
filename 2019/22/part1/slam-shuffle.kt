package aoc

fun slamShuffle(data: List<String>): Int {

    var stack = mutableListOf<Int>()

    for (i in (0..10006))
        stack.add(i)

    for (line in data) {
        if (line == "deal into new stack") {
            stack.reverse()
        } else if (line.startsWith("deal with increment")) {
            val increment = line.substring(20).toInt()

            val newStack = stack.toMutableList()

            var index = 0
            var offset = 0
            while (offset < stack.count()) {
                newStack[index % stack.count()] = stack[offset++]
                index += increment
            }

            stack = newStack
        }
        else if (line.startsWith("cut")) {
            var cut = line.substring(4).toInt()
            if (cut > 0 ) {
                val newStack = (stack.subList(cut, stack.count()) + stack.subList(0, cut))
                stack = newStack.toMutableList()
            } else {
                cut = cut * -1
                val newStack = stack.subList(stack.count() - cut, stack.count()) + stack.subList(0, stack.count() - cut)
                stack = newStack.toMutableList()
            }
        }
    }

    var i = 0
    for (value in stack) {
        if (value == 2019)
            return i
        i++
    }

    return i
}