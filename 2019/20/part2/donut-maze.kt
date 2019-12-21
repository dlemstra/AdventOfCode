package aoc

data class Position(val x: Int, val y: Int)

data class MapPosition(val position: Position, val steps: Int, val visited: Map<Int, List<Position>>, val level: Int)

fun isStep(value: Char?) = value != null && value == '.'

fun isPortal(value: Char?) = value != null && (value >= 'A' && value <= 'Z')

fun validChar(value: Char?) = isStep(value) || isPortal(value)

fun findRelated(map: Map<Position, Char>, position: Position): Position {
    val north = Position(position.x, position.y-1)
    if (isPortal(map[north]))
        return north

    val east = Position(position.x+1, position.y)
    if (isPortal(map[east]))
        return east

    val south = Position(position.x, position.y+1)
    if (isPortal(map[south]))
        return south

    val west = Position(position.x-1, position.y)
    if (isPortal(map[west]))
        return west

    throw UnsupportedOperationException()
}

fun findCharacter(map: Map<Position, Char>, value: Char): Position {
    for (position in map.filter{ it.value == value }.keys) {
        if (map[findRelated(map, position)] != value)
            continue

        if (map[Position(position.x+1, position.y)] == '.')
            return position
        if (map[Position(position.x-1, position.y)] == '.')
            return position
        if (map[Position(position.x, position.y+1)] == '.')
            return position
        if (map[Position(position.x, position.y-1)] == '.')
            return position
    }

    throw UnsupportedOperationException()
}

fun findStep(map: Map<Position, Char>, position: Position): Position? {
     val north = Position(position.x, position.y-1)
    if (isStep(map[north]))
        return north

    val east = Position(position.x+1, position.y)
    if (isStep(map[east]))
        return east

    val south = Position(position.x, position.y+1)
    if (isStep(map[south]))
        return south

    val west = Position(position.x-1, position.y)
    if (isStep(map[west]))
        return west

    return null
}

fun findExit(map: Map<Position, Char>, position: Position): Position {
    val source = map[position]
    val sourceRelated = findRelated(map, position)

    for (target in map.filter{ it.value == source }.keys) {
        if (target == position)
            continue

        val targetRelated = findRelated(map, target)
        if (targetRelated == position)
            continue

        if (map[sourceRelated] != map[targetRelated])
            continue

        if (findStep(map, target) != null)
            return target

        return targetRelated
    }

    throw UnsupportedOperationException()
}

fun possiblePositions(map: Map<Position, Char>, mapPosition: MapPosition): List<Position> { 
    val result = mutableListOf<Position>()
    val position = mapPosition.position
    val visited = mapPosition.visited[mapPosition.level] !!

    val north = Position(position.x, position.y-1)
    if (!visited.contains(north) && validChar(map[north]))
        result.add(north)

    val east = Position(position.x+1, position.y)
    if (!visited.contains(east) && validChar(map[east]))
        result.add(east)

    val south = Position(position.x, position.y+1)
    if (!visited.contains(south) && validChar(map[south]))
        result.add(south)

    val west = Position(position.x-1, position.y)
    if (!visited.contains(west) && validChar(map[west]))
        result.add(west)

    return result
}

fun isOuter(map: Map<Position, Char>, position: Position): Boolean {
    if (position.x == 1)
        return true
    if (position.y == 1)
        return true

    val maxX = map.map{ it.key.x }.max() !!
    if (position.x == maxX - 1)
        return true

    val maxY = map.map{ it.key.y }.max() !!
    if (position.y == maxY - 1)
        return true

    return false
}

fun closeWalls(map: Map<Position, Char>, steps: List<Position>, keepStepsOpen: Boolean): Map<Position, Char> {
    val result = map.toMutableMap()

    val maxX = map.map{ it.key.x }.max() !!
    val maxY = map.map{ it.key.y }.max() !!

    for (y in (2..maxY-2)) {
        var x = 2
        while (x < maxX-2) {
            val position = Position(x++, y)
            if (steps.contains(position)) {
                if (!keepStepsOpen)
                    result[position] = '#'
            } else if (keepStepsOpen) {
                result[position] = '#'
            }
            if (y != 2 && y != maxY-2)
                x += maxX-4
        }
    }

    return result
}

fun portalCount(map: Map<Position, Char>): Int {
    val portals = mutableListOf<String>()

    for ((key, value) in map) {
        if (isPortal(value)) {
            val related = findRelated(map, key)
            val name = listOf(value, map[related]!!).sorted().joinToString("")
            portals.add(name)
        }
    }

    return portals.distinct().count()
}

fun findBestDistance(input: MutableMap<Position, Char>): Int {
    var start = findCharacter(input, 'A')
    val end = findCharacter(input, 'Z')
    val portalCount = portalCount(input)

    val startStep = findStep(input, start)!!

    val steps = listOf(startStep, findStep(input, end)!!)

    val outermost = closeWalls(input, steps, true)
    val innermap = closeWalls(input, steps, false)

    val visitedStart = mutableMapOf<Int, List<Position>>()
    visitedStart[0] = listOf(start)

    val queue = mutableListOf<MapPosition>()
    queue.add(MapPosition(startStep, 0, visitedStart, 0))

    while (queue.count() != 0) {
        val mp = queue.removeAt(0)

        val map = if (mp.level == 0) outermost else innermap

        var visited = mp.visited.toMutableMap()
        visited[mp.level] = (visited[mp.level]!!) + mp.position

        for (newPosition in possiblePositions(map, mp)) {
            if (mp.level == 0 && newPosition == end)
                return mp.steps

            if (isPortal(map[newPosition])) {
                var level = mp.level
                if (isOuter(input, newPosition))
                    level--
                else
                    level++

                if (level < 0 || level > portalCount)
                    continue

                val exit = findExit(input, newPosition)
                val step = findStep(input, exit) !!

                visited[mp.level] = (visited[mp.level]!!).filter{ isPortal(input[it]) }

                if (visited[level] == null)
                    visited[level] = listOf<Position>(exit)
                else
                    visited[level] = ((visited[level]!!) + exit).distinct()

                queue.add(MapPosition(step, mp.steps + 1, visited, level))
            } else {
                queue.add(MapPosition(newPosition, mp.steps + 1, visited, mp.level))
            }
        }
    }

    return -1
}

fun donutMaze(data: List<String>): Int {
    val map = mutableMapOf<Position, Char>()

    var x = 0
    var y = 0
    for (line in data) {
        for (value in line) {
            var position = Position(x, y)
            map[position] = value

            x++
        }
        y++
        x = 0
    }

    return findBestDistance(map)
}