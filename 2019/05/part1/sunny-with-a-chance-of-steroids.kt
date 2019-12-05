package aoc

fun getValue(values: MutableList<Int>, value: Int, mode: Int): Int {
    if (mode == 0) {
        if (value > values.count())
            return Int.MIN_VALUE

        return values[value]
    }

    if (mode == 1)
        return value

    return Int.MIN_VALUE
}

fun sunnyWithAChanceOfSteroids(input: String): Int {
    var values = input.split(",").map{ it.toInt() }.toMutableList()

    var i = 0
    var code = 1

    while (true) {
        var info = arrayOf<Int>(0, 0, 0, 0, 0)

        var opcode = values[i++]
        if (opcode > 99) {
            var items = opcode.toString().toList().map{ it.toString().toInt() }.asReversed().toTypedArray();
            items.copyInto(info, 0, 0, items.count())

            opcode = info[0] + info[1] * 10
        }

        if (opcode == 99)
            break

        if (opcode == 3)
            info[2] = 1

        val param1 = getValue(values, values[i++], info[2])
        val param2 = getValue(values, values[i+0], info[3])
        val param3 = getValue(values, values[i+1], 1)

        when (opcode) {
            1 -> {
                values[param3] = param1 + param2
                i += 2
            }
            2 -> {
                values[param3] = param1 * param2
                i += 2
            }
            3 -> values[param1] = code
            4 -> code = param1
            else -> throw UnsupportedOperationException("$opcode")
        }
    }

    return code
}