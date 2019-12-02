package aoc

fun programAlarm(items: MutableList<Int>, noun: Int, verb: Int): Int {
    items[1] = noun
    items[2] = verb
    for (i in 0 until items.count() - 1 step 4) {
        val opcode = items[i]
        if (opcode < 1 || opcode > 2)
            break
        val a = items[items[i + 1]]
        val b = items[items[i + 2]]
        val index = items[i + 3]
        items[index] = if (opcode == 1) a + b else a * b
    }

    return items[0]
}

fun programAlarm(input: String): Int {
    val items = input.split(",").map{ it.toInt() }.toList()

    for (noun in 0..99) {
        for (verb in 0..99) {
            val result = programAlarm(items.toMutableList(), noun, verb)
            if (result == 19690720) {
                return 100 * noun + verb
            }
        }
    }

    return -1;
}