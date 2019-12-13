package aoc

class Intcode(values: List<Long>) {
    private val values = values.withIndex().associateBy({it.index.toLong()}, {it.value}).toMutableMap()
    private var i = 0L
    private var opcode = 0L
    private var base = 0L
    private val inputs = mutableListOf<Long>()
    private val operationsWithResult = arrayOf(1L, 2L, 7L, 8L)
    var done = false

    fun execute(input: Long) : List<Long> {
        inputs.add(input)

        val output = mutableListOf<Long>()

        while (true) {
            var modes = arrayOf<Int>(0, 0, 0, 0, 0)

            opcode = values[i++] !!
            if (opcode > 99L) {
                var items = opcode.toString().toList().map{ it.toString().toInt() }.asReversed().toTypedArray();
                items.copyInto(modes, 0, 0, items.count())

                opcode = modes[0] + modes[1] * 10L
            }

            if (opcode == 99L)
                break

            if (opcode == 3L && modes[2] != 2)
                modes[2] = 1

            if (modes[4] != 2)
                modes[4] = 1

            val param1 = getValue(i++, modes[2], opcode == 3L)
            val param2 = getValue(i+0, modes[3], false)
            val param3 = getValue(i+1, modes[4], operationsWithResult.contains(opcode))

            when (opcode.toInt()) {
                1 -> {
                    values[param3] = param1 + param2
                    i += 2
                }
                2 -> {
                    values[param3] = param1 * param2
                    i += 2
                }
                3 -> {
                    if (inputs.count() == 0) {
                        i -= 2
                        return output
                    }
                    values[param1] = inputs.removeAt(0)
                }
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

        done = true
        return output
    }

    private fun getValue(index: Long, mode: Int, isOutput: Boolean): Long {
        if (!values.containsKey(index))
            return 0

        val value = values[index] !!
        if (mode == 1)
            return value

        if (mode == 0) {
            if (!values.containsKey(value)) {
                return 0
            }

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

fun getPosition(ball: Long, paddle: Long): Long {
    if (paddle < ball)
        return 1L
    else if (ball < paddle)
        return -1L

    return 0L
}

fun carePackage(data: String): Long {
    val values = data.split(",").map{ it.toLong() }.toMutableList()

    values[0] = 2L
    val intCode = Intcode(values)

    var position = 0L
    var lastBall = 0L
    var lastPaddle = 0L
    var lastTile = 0L
    while (!intCode.done) {
        var output = intCode.execute(position)

        var i = 0
        while (i < output.count()) {
            val x = output[i++]
            i++
            lastTile = output[i++]

            if (lastTile == 3L) {
                lastPaddle = x
                position = getPosition(lastBall, lastPaddle)
            }
            else if (lastTile == 4L) {
                lastBall = x
                position = getPosition(lastBall, lastPaddle)
            }
        }
    }

    return lastTile
}