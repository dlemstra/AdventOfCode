package aoc

data class Position(val x: Int, val y: Int)

fun Position.north() = Position(x, y - 1)
fun Position.east() = Position(x + 1, y)
fun Position.south() = Position(x, y + 1)
fun Position.west() = Position(x - 1, y)

fun infect(map: Map<Position, Char>): Map<Position, Char> {
    val newMap = map.toMutableMap()

    for (position in map.keys) {
        var total = if (map[position.north()] == '#') 1 else 0
        if (map[position.east()] == '#') total++
        if (map[position.south()] == '#') total++
        if (map[position.west()] == '#') total++

        if (map[position] == '#')
            newMap[position] = if (total == 1) '#' else '.'
        else
            newMap[position] = if (total == 1 || total == 2) '#' else '.'
    }

    return newMap
}

fun checkSum(map: Map<Position, Char>): Long {
    var result = 0L
    var pow = 1L

    val maxX = map.map{ it.key.x }.max() !!
    val maxY = map.map{ it.key.y }.max() !!

    for (y in (0..maxY)) {
        for (x in (0..maxX)) {
            if (map[Position(x, y)] == '#')
                result += pow

             pow *= 2
        }
    }

    return result
}

fun readMap(data: List<String>): Map<Position, Char> {
     var map = mutableMapOf<Position, Char>()

    var y = 0
    for (line in data) {
        var x = 0
        for (char in line) {
            map[Position(x, y)] = char
            x++
        }
        y++
    }

    return map
}

fun planetOfDiscord(data: List<String>): Long {
    var map = readMap(data)
    val found = mutableListOf<String>()

    while (true) {
        map = infect(map)
        var mapString = map.toString()
        if (found.contains(mapString))
            break
        found.add(mapString)
    }

    return checkSum(map)
}