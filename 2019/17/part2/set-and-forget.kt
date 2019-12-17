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

enum class Direction(val value: Int) {
    North(0),
    East(1),
    South(2),
    West(3)
}

fun isScaffold(value: Long): Boolean = value == 35L

fun isScaffold(map: Map<String, Long>, x: Int, y: Int): Boolean {
    val key = "$x,$y"
    return map.containsKey(key) && isScaffold(map[key] !!)
}

fun createProgram(map: MutableMap<String, Long>, startX: Int, startY: Int, startDirection: Direction): String {
    val result = mutableListOf<String>();

    var x = startX
    var y = startY

    var direction = startDirection
    var turn = "L"

    if (isScaffold(map, startX - 1, startY)) {
        turn = if (direction == Direction.North) "L" else "R"
        direction = Direction.West
    } else if (isScaffold(map, startX + 1, startY)) {
        turn = if (direction == Direction.North) "R" else "L"
        direction = Direction.East
    } else if (isScaffold(map, startX, startY - 1)) {
        turn = if (direction == Direction.East) "L" else "R"
        direction = Direction.North
    } else if (isScaffold(map, startX, startY + 1)) {
        turn = if (direction == Direction.East) "R" else "L"
        direction = Direction.South
    }

    result.add(turn)

    var steps = 0
    while (true) {
        var newY = y
        var newX = x

        when (direction) {
            Direction.North -> newY--
            Direction.East -> newX++
            Direction.South -> newY++
            Direction.West -> newX--
        }

        if (!isScaffold(map, newX, newY)) {
            result.add(steps.toString())

            newY = y
            newX = x

            when (direction) {
                Direction.North -> newX--
                Direction.East -> newY--
                Direction.South -> newX++
                Direction.West -> newY++
            }

            if (isScaffold(map, newX, newY)) {
                result.add("L")

                when (direction) {
                    Direction.North -> direction = Direction.West
                    Direction.East -> direction = Direction.North
                    Direction.South -> direction = Direction.East
                    Direction.West -> direction = Direction.South
                }
            } else {
                newY = y
                newX = x

                when (direction) {
                    Direction.North -> newX++
                    Direction.East -> newY++
                    Direction.South -> newX--
                    Direction.West -> newY--
                }

                if (!isScaffold(map, newX, newY))
                    return result.joinToString(",")

                result.add("R")

                when (direction) {
                    Direction.North -> direction = Direction.East
                    Direction.East -> direction = Direction.South
                    Direction.South -> direction = Direction.West
                    Direction.West -> direction = Direction.North
                }
            }

            steps=0
        }

        x = newX
        y = newY
        steps++
    }
}

fun findFunction(path: String): String {
    var start = 0
    var end = path.indexOf(",", path.indexOf(",") + 1)

    while (true) {
        val newEnd = path.indexOf(",", path.indexOf(",", end + 1) + 1)
        if (newEnd > 20)
            return path.substring(start, end)

        var function = path.substring(start, newEnd)
        if (path.indexOf(function, function.length + 1) == -1)
            return path.substring(start, end)
        end = newEnd
    }
}

fun createInput(code: String): List<Long> {
    var result = mutableListOf<Long>()
    for (char in code) {
        result.add(char.toLong())
    }

    result.add(10L)
    return result
}

fun setAndForget(data: String): Long {
    val values = data.split(",").map{ it.toLong() }.toMutableList()

    values[0] = 2

    var x = 0
    var y = 0
    var startX = 0
    var startY = 0
    var startDirection = Direction.North

    var map = mutableMapOf<String, Long>()

    val intcode = Intcode(values)
    for (output in intcode.execute()) {
        if (output == 10L) {
            y++
            x = 0
        } else {
            if (startX == 0 && output > 46L) {
                startX = x
                startY = y

                when (output) {
                    92L -> startDirection = Direction.North
                    62L -> startDirection = Direction.East
                    118L -> startDirection = Direction.South
                    60L -> startDirection = Direction.West
                }
            }

            map["$x,$y"] = output
            x++
        }
    }

    var program = createProgram(map, startX, startY, startDirection)

    var instructions = program + ","
    val functionA = findFunction(instructions)

    instructions = instructions.replace(functionA + ",", "")
    val functionB = findFunction(instructions)

    instructions = instructions.replace(functionB + ",", "")
    val functionC = findFunction(instructions)

    program = program.replace(functionA, "A")
    program = program.replace(functionB, "B")
    program = program.replace(functionC, "C")

    intcode.execute(createInput(program))
    intcode.execute(createInput(functionA))
    intcode.execute(createInput(functionB))
    intcode.execute(createInput(functionC))

    val output = intcode.execute(createInput("n"))

    return output[output.lastIndex]
}