package aoc

class Intcode() {
    private var values = mutableMapOf<Long,Long>()
    private var i = 0L
    private var opcode = 0L
    private var base = 0L
    private val inputs = mutableListOf<Long>()
    private val operationsWithResult = arrayOf(1L, 2L, 7L, 8L)
    var done = false

    constructor(values: List<Long>): this() {
        this.values = values.withIndex().associateBy({it.index.toLong()}, {it.value}).toMutableMap()
    }

    fun copy(): Intcode {
        val result = Intcode()
        result.values = values.toMutableMap()
        result.i = i
        result.base = base

        return result
    }

    fun execute(input: List<Long> ) : List<Long> {
        inputs.addAll(input)

        return execute()
    }

    fun execute(input: Long) : List<Long> {
        inputs.add(input)

        return execute()
    }

    fun execute() : List<Long> {
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

fun printOutput(output: MutableList<Long>) {
    var damage = ""
    if (output[output.lastIndex] != 10L) {
        damage = "Hull damage: ${output[output.lastIndex]}"
        output[output.lastIndex] = 10L
    }

    println(output.map{ it.toChar() }.joinToString("") + damage)
}

fun createInput(code: String): List<Long> {
    var result = mutableListOf<Long>()
    for (char in code) {
        result.add(char.toLong())
    }

    result.add(10L)
    return result
}

fun tractorBeam(data: String, input: List<String>) {
    val values = data.split(",").map{ it.toLong() }.toMutableList()

    val intcode = Intcode(values)
    intcode.execute()

    for (line in input)
        intcode.execute(createInput(line))

    val output = intcode.execute(createInput("WALK"))
    printOutput(output.toMutableList())
}
