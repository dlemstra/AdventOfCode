package aoc

class Intcode(values: List<Int>, phase: Int) {
    private var values = values.toMutableList()
    private var inputs = mutableListOf(phase)
    private var i = 0
    private var opcode = 0

    val done: Boolean
        get() = opcode == 99

    fun execute(input: Int): Int {
        inputs.add(input)

        return execute()
    }

    private fun execute(): Int {
        while (true) {
            var info = arrayOf<Int>(0, 0, 0, 0, 0)

            opcode = values[i++]
            if (opcode > 99) {
                var items = opcode.toString().toList().map{ it.toString().toInt() }.asReversed().toTypedArray();
                items.copyInto(info, 0, 0, items.count())

                opcode = info[0] + info[1] * 10
            }

            if (opcode == 99)
                break

            if (opcode == 3)
                info[2] = 1

            val param1 = getValue(values, i++, info[2])
            val param2 = getValue(values, i+0, info[3])
            val param3 = getValue(values, i+1, 1)

            when (opcode) {
                1 -> {
                    values[param3] = param1 + param2
                    i += 2
                }
                2 -> {
                    values[param3] = param1 * param2
                    i += 2
                }
                3 -> values[param1] = inputs.removeAt(0)
                4 -> return param1
                5 -> i = if (param1 != 0) param2 else i + 1
                6 -> i = if (param1 == 0) param2 else i + 1
                7 -> {
                    values[param3] = if (param1 < param2) 1 else 0
                    i += 2
                }
                8 -> {
                    values[param3] = if (param1 == param2) 1 else 0
                    i += 2
                }
                else -> throw UnsupportedOperationException("$opcode")
            }
        }
        return 0
    }

    private fun getValue(values: MutableList<Int>, index: Int, mode: Int): Int {
        if (index >= values.count())
            return Int.MIN_VALUE

        val value = values[index]
        if (mode == 1)
            return value

        if (mode == 0) {
            if (value >= values.count())
                return Int.MIN_VALUE

            return values[value]
        }

        return Int.MIN_VALUE
    }
}

fun amplificationCircuit(input: String): Int {
    var values = input.split(",").map{ it.toInt() }

    var best = Int.MIN_VALUE

    for (phases in listOf(5, 6, 7, 8, 9).permutations()) {
        var intCodes = listOf<Intcode>(
            Intcode(values, phases[0]),
            Intcode(values, phases[1]),
            Intcode(values, phases[2]),
            Intcode(values, phases[3]),
            Intcode(values, phases[4])
        )

        var output = 0
        while (!intCodes[0].done) {
            for (i in (0..4)) {
                output = intCodes[i].execute(output)
                if (intCodes[i].done)
                    break
            }
            best = maxOf(output, best)
        }
    }

    return best;
}