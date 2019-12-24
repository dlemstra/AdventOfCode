package aoc

data class Position(val x: Int, val y: Int)

fun Position.north() = Position(x, y - 1)
fun Position.east() = Position(x + 1, y)
fun Position.south() = Position(x, y + 1)
fun Position.west() = Position(x - 1, y)

class Tile() {
    private var depth = 0
    private var values = Array(5){ Array(5){'.'} }
    var inner: Tile? = null
    var outer: Tile? = null

    constructor(depth: Int): this() {
        this.depth = depth
        values[2][2] = '?'
    }

    constructor(data: List<String>): this(0) {
        for (y in (0..4))
            for (x in (0..4))
                values[y][x] = data[y][x]
    }

    fun extent() {
        if (inner == null) {
            inner = Tile(depth + 1)
            inner!!.outer = this
        }
        else if (depth >= 0)
            inner!!.extent()

        if (outer == null) {
            outer = Tile(depth - 1)
            outer!!.inner = this
        }
        else if (depth <= 0)
            outer!!.extent()
    }

    fun infect() {
        val newValues = Array(5){ Array(5){'.'} }

        for (y in (0..4)) {
            for (x in (0..4)) {
                if (y == 2 && x == 2) {
                    newValues[y][x] = '?'
                    continue
                }

                var total = 0

                if (outer != null) {
                    if (y == 0 && outer!!.values[1][2] == '#') // 8
                        total++
                    if (y == 4 && outer!!.values[3][2] == '#') // 18
                        total++
                    if (x == 0 && outer!!.values[2][1] == '#') // 12
                        total++
                    if (x == 4 && outer!!.values[2][3] == '#') // 14
                        total++
                }

                if (inner != null) {
                    if (x == 2 && y == 1) { // 8 = H
                        if (inner!!.values[0][0] == '#') // A
                            total++
                        if (inner!!.values[0][1] == '#') // F
                            total++
                        if (inner!!.values[0][2] == '#') // K
                            total++
                        if (inner!!.values[0][3] == '#') // P
                            total++
                        if (inner!!.values[0][4] == '#') // U
                            total++
                    }
                    if (x == 3 && y == 2) { // 14 = N
                        if (inner!!.values[0][4] == '#') // E
                            total++
                        if (inner!!.values[1][4] == '#') // J
                            total++
                        if (inner!!.values[2][4] == '#') // O
                            total++
                        if (inner!!.values[3][4] == '#') // T
                            total++
                        if (inner!!.values[4][4] == '#') // V
                            total++
                    }
                    if (x == 2 && y == 3) { // 18 = R
                        if (inner!!.values[4][0] == '#') // U
                            total++
                        if (inner!!.values[4][1] == '#') // V
                            total++
                        if (inner!!.values[4][2] == '#') // W
                            total++
                        if (inner!!.values[4][3] == '#') // X
                            total++
                        if (inner!!.values[4][4] == '#') // Y
                            total++
                    }
                    if (x == 1 && y == 2) { // 12 = L
                        if (inner!!.values[0][0] == '#') // A
                            total++
                        if (inner!!.values[1][0] == '#') // F
                            total++
                        if (inner!!.values[2][0] == '#') // K
                            total++
                        if (inner!!.values[3][0] == '#') // P
                            total++
                        if (inner!!.values[4][0] == '#') // U
                            total++
                    }
                }

                if (x > 0 && values[y][x-1] == '#')
                    total++

                if (x < 4 && values[y][x+1] == '#')
                    total++

                if (y > 0 && values[y-1][x] == '#')
                    total++

                if (y < 4 && values[y+1][x] == '#')
                    total++

                newValues[y][x] = values[y][x]

                when (values[y][x]) {
                    '.' -> {
                        if (total == 1 || total == 2)
                            newValues[y][x] = '#'
                    }
                    '#' -> {
                        if (total != 1)
                            newValues[y][x] = '.'
                    }
                }
            }
        }

        if (canGoDown())
            inner!!.infect()

        if (canGoUp())
            outer!!.infect()

        values = newValues
    }

    fun countBugs(): Long {
        var count = 0L

        for (y in (0..4))
            for (x in (0..4))
                if (values[y][x] == '#')
                    count++

        if (canGoDown())
            count += inner!!.countBugs()

        if (canGoUp())
            count += outer!!.countBugs()

        return count
    }

     fun print() {
        if (canGoUp())
            outer!!.print()

        var result = mutableListOf<String>()
        result.add("")
        result.add("Depth $depth:")
        for (y in (0..4)) {
            val row = mutableListOf<Char>()
            for (x in (0..4))
                row.add(values[y][x])
            result.add(row.joinToString(""))
        }

        println(result.joinToString("\n"))

        if (canGoDown())
            inner!!.print()
    }

    private fun canGoDown() = inner != null && depth >= 0

    private fun canGoUp() = outer != null && depth <= 0
}

fun planetOfDiscord(data: List<String>): Long {
    val center = Tile(data)

    for (i in (1..200)) {
        center.extent()
        center.infect()
    }

    return center.countBugs()
}