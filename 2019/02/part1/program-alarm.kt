package aoc

fun programAlarm(input: String): Int {
    var items = input.split(",").map{ it.toInt() }.toMutableList()

    // HACK
    if (items.count() > 20 ) {
        items[1] = 12
        items[2] = 2
    }

    for (i in 0 until items.count() - 1 step 4) {
        val opcode = items[i]
        if (opcode < 1 || opcode > 2)
            break
        val a = items[items[i + 1]]
        val b = items[items[i + 2]]
        val index = items[i + 3]
        if (index >= items.count())
            break
        var result = if (opcode == 1) a + b else a * b
        items[index] = result
    }

    return items[0];
}