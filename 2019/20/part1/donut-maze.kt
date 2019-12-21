package aoc

data class Position(val x: Int, val y: Int)

data class MapPosition(val position: Position, val distance: Int, val visited: List<Position>)

fun isStep(value: Char?) = value != null && value == '.'

fun isPortal(value: Char?) = value != null && (value >= 'A' && value <= 'Z')

fun validChar(value: Char?) = isStep(value) || isPortal(value)

fun findCharacter(map: Map<Position, Char>, value: Char): Position {
    for (position in map.filter{ it.value == value }.keys) {
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

fun findExit(map: Map<Position, Char>, position: Position): Position {
    val source = map[position]
    val target = map[findRelated(map, position)]

    for (newPosition in map.filter{ it.value == source }.keys) {
        if (newPosition == position)
            continue

        val related = findRelated(map, newPosition)
        val otherTarget = map[related]
        if (target != otherTarget)
            continue

        if (findStep(map, related) != null)
            return related

        return newPosition
    }

    throw UnsupportedOperationException()
}

fun possiblePositions(map: Map<Position, Char>, mapPosition: MapPosition): List<Position> { 
    val result = mutableListOf<Position>()
    val position = mapPosition.position

    val north = Position(position.x, position.y-1)
    if (!mapPosition.visited.contains(north) && validChar(map[north]))
        result.add(north)

    val east = Position(position.x+1, position.y)
    if (!mapPosition.visited.contains(east) && validChar(map[east]))
        result.add(east)

    val south = Position(position.x, position.y+1)
    if (!mapPosition.visited.contains(south) && validChar(map[south]))
        result.add(south)

    val west = Position(position.x-1, position.y)
    if (!mapPosition.visited.contains(west) && validChar(map[west]))
        result.add(west)

    return result
}

fun findBestDistance(map: Map<Position, Char>): Int {
    val start = findCharacter(map, 'A')
    val end = findCharacter(map, 'Z')

    val queue = mutableListOf<MapPosition>()
    queue.add(MapPosition(start, 0, listOf<Position>()))

    var best = Int.MAX_VALUE

    while (queue.isNotEmpty()) {
        val mp = queue.removeAt(0)

        for (newPosition in possiblePositions(map, mp)) {
            if (newPosition == end)
                return mp.distance - 1

            if (isPortal(map[newPosition])) {
                val exit = findExit(map, newPosition)
                val step = findStep(map, exit) !!

                queue.add(MapPosition(step, mp.distance + 1, mp.visited + newPosition + exit))
            } else {
                queue.add(MapPosition(newPosition, mp.distance + 1, mp.visited + mp.position))
            }
        }
    }

    return best
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