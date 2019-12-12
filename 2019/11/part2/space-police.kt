package aoc

class Intcode(values: List<Long>) {
    private val values = values.withIndex().associateBy({it.index.toLong()}, {it.value}).toMutableMap()
    private var i = 0L
    private var opcode = 0L
    private var base = 0L
    private val inputs = mutableListOf<Long>()
    private val operationsWithResult = arrayOf(1L, 2L, 7L, 8L)

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

        return listOf<Long>()
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

fun printColors(colors: Map<String, Long>) {
    val maxX = colors.map{ it.key.split(",")[0].toInt() }.max() !!
    val maxY = colors.map{ it.key.split(",")[1].toInt() }.max() !!

    for (y in (0..maxY)) {
        for (x in (0..maxX)) {
            if (colors.containsKey("$x,$y") && colors["$x,$y"] == 1L) {
                print('#')
            } else {
                print(' ')
            }
        }
        println()
    }
}

fun spacePolice(data: String) {
    val values = data.split(",").map{ it.toLong() }

    val intCode = Intcode(values)

    var x = 0
    var y = 0
    var direction = 0

    val colors = mutableMapOf<String, Long>()
    colors["0,0"] = 1

    while (true) {

        var input = 0L
        if (colors.containsKey("$x,$y")) {
            input = colors["$x,$y"] !!
        }

        val output = intCode.execute(input)
        if (output.count() == 0)
            break

        colors["$x,$y"] = output[0]

        when (direction) {
            0 -> direction = if (output[1] == 0L) 3 else 1
            1 -> direction = if (output[1] == 0L) 0 else 2
            2 -> direction = if (output[1] == 0L) 1 else 3
            3 -> direction = if (output[1] == 0L) 2 else 0
        }

        when (direction) {
            0 -> y--
            1 -> x++
            2 -> y++
            3 -> x--
        }
    }

    printColors(colors)
}