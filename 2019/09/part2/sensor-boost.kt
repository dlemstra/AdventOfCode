package aoc

class Intcode(values: List<Long>) {
    private var values = values.withIndex().associateBy({it.index.toLong()}, {it.value}).toMutableMap()
    private var i = 0L
    private var opcode = 0L
    private var base = 0L
    private var output = mutableListOf<Long>()

    fun execute(input: Long) : List<Long> {

        var operationsWithResult = arrayOf(1L, 2L, 7L, 8L)

        while (true) {
            var info = arrayOf<Int>(0, 0, 0, 0, 0)

            opcode = values[i++] !!
            if (opcode > 99L) {
                var items = opcode.toString().toList().map{ it.toString().toInt() }.asReversed().toTypedArray();
                items.copyInto(info, 0, 0, items.count())

                opcode = info[0] + info[1] * 10L
            }

            if (opcode == 99L)
                break

            if (opcode == 3L && info[2] != 2)
                info[2] = 1

            if (info[4] != 2)
                info[4] = 1

            val param1 = getValue(i++, info[2], opcode == 3L)
            val param2 = getValue(i+0, info[3], false)
            val param3 = getValue(i+1, info[4], operationsWithResult.contains(opcode))

            when (opcode.toInt()) {
                1 -> {
                    values[param3] = param1 + param2
                    i += 2
                }
                2 -> {
                    values[param3] = param1 * param2
                    i += 2
                }
                3 -> values[param1] = input
                4 -> output.add(param1)
                5 -> i = if (param1 != 0L) param2 else i + 1
                6 -> i = if (param1 == 0L) param2 else i + 1
                7 -> {
                    values[param3] = if (param1 < param2) 1L else 0L
                    i += 2
                }
                8 -> {
                    values[param3] = if (param1 == param2) 1L else 0L
                    i += 2
                }
                9 -> base += param1
                else -> throw UnsupportedOperationException("OPCODE: $opcode")
            }
        }

        return output
    }

    private fun getValue(index: Long, mode: Int, isOutput: Boolean): Long {
        if (!values.containsKey(index))
            return 0

        val value = values[index] !!
        if (mode == 1)
            return value

        if (mode == 0) {
            if (!values.containsKey(value))
                return 0

            return values[value] !!
        }

        if (mode == 2) {
            val offset = base + value
            if (isOutput)
                return offset

            if (!values.containsKey(offset))
                return 0

            return values[offset] !!
        }


        throw UnsupportedOperationException("MODE: $mode")
    }
}

fun sensorBoost(input: String): Long {
    val values = input.split(",").map{ it.toLong() }

    val intCode = Intcode(values)
    val output = intCode.execute(2L)

    if (output.count() != 1)
        throw UnsupportedOperationException("$output")

    return output[0]
}