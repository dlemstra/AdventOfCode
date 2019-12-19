package aoc

data class Position(val x: Int, val y: Int)

data class MapPosition(val position: Position, val requiredKeys: List<Char>, val distance: Int)

fun isStart(value: Char) = value == '@'

fun isKey(value: Char) = value >= 'a' && value <= 'z'

fun isDoor(value: Char) = value >= 'A' && value <= 'Z'

fun validPositions(map: Map<String, Char>, position: Position): List<Position> {
    var positions = mutableListOf<Position>()

    val x = position.x
    val y = position.y

    var north = Position(x, y-1)
    if (map["${north.x},${north.y}"] != '#')
        positions.add(north)

    var east = Position(x+1, y)
    if (map["${east.x},${east.y}"] != '#')
        positions.add(east)

    var south = Position(x, y+1)
    if (map["${south.x},${south.y}"] != '#')
        positions.add(south)

    var west = Position(x-1, y)
    if (map["${west.x},${west.y}"] != '#')
        positions.add(west)

    return positions
}

fun findKeys(map: Map<String, Char>, startPosition: Position): List<MapPosition> {
    val result = mutableListOf<MapPosition>()

    val found = mutableMapOf<String, Boolean>()
    val queue = mutableListOf<MapPosition>()
    queue.add(MapPosition(startPosition, listOf<Char>(), 0))

    while (queue.count() > 0) {
        var mapPosition = queue.removeAt(0)

        for (position in validPositions(map, mapPosition.position)) {
            if (found.containsKey("${position.x},${position.y}"))
                continue

            found["${position.x},${position.y}"] = true

            val value = map["${position.x},${position.y}"] !!
            if (isKey(value))
                result.add(MapPosition(position, mapPosition.requiredKeys, mapPosition.distance + 1))

            val newKeys = mapPosition.requiredKeys.toMutableList()
            if (isDoor(value))
                newKeys.add(value.toLowerCase())

            queue.add(MapPosition(position, newKeys, mapPosition.distance + 1))
        }
    }

    return result
}

fun findPossibleKeys(map: Map<String, Char>, position: Position, distances: Map<Char, List<MapPosition>>, unlockedDoors: List<Char>): List<MapPosition> {
    val possibleKeys = mutableListOf<MapPosition>()

    val value = map["${position.x},${position.y}"] !!
    for (mapPosition in distances[value] !!) {
        val keyValue = map["${mapPosition.position.x},${mapPosition.position.y}"] !!
        if (unlockedDoors.contains(keyValue))
            continue
        if ((mapPosition.requiredKeys - unlockedDoors).count() != 0)
            continue

        possibleKeys.add(mapPosition)
    }

    return possibleKeys
}

fun findBestDistance(map: Map<String, Char>, position: Position, distances: Map<Char, List<MapPosition>>, unlockedDoors: List<Char> = listOf<Char>(), discovered: MutableMap<String, Int> = mutableMapOf<String, Int>()): Int {
    var discoveredKey = (unlockedDoors + (map["${position.x},${position.y}"] !!)).sorted().joinToString("")

    if (!discovered.containsKey(discoveredKey)) {
        val possibleKeys = findPossibleKeys(map, position, distances, unlockedDoors)

        var value = 0
        if (possibleKeys.count() != 0) {
            value = Int.MAX_VALUE
            for (key in possibleKeys) {
                val keyValue = map["${key.position.x},${key.position.y}"] !!
                val newUnlockedDoors = unlockedDoors.toMutableList() + keyValue

                val distance = key.distance + findBestDistance(map, key.position, distances, newUnlockedDoors, discovered)
                value = minOf(value, distance)
            }
        }

        discovered[discoveredKey] = value
    }

    return discovered[discoveredKey] !!
}

fun findBestDistance(map: Map<String, Char>, keyPositions: Map<Char, Position>, startPosition: Position): Int {
    val distances = mutableMapOf<Char, List<MapPosition>>()
    distances['@'] = findKeys(map, startPosition)

    for ((key, position) in keyPositions)
        distances[key] = findKeys(map, position)

    return findBestDistance(map, startPosition, distances)
}

fun manyWorldsInterpretation(data: List<String>): Int {
    var startPosition = Position(0, 0)
    val keyPositions = mutableMapOf<Char, Position>()
    val map = mutableMapOf<String, Char>()

    var x = 0
    var y = 0
    for (line in data) {
        for (value in line) {
            var position = Position(x, y)
            map["${position.x},${position.y}"] = value

            if (isStart(value))
                startPosition = position
            else if (isKey(value))
                keyPositions[value] = position

            x++
        }
        y++
        x = 0
    }

    return findBestDistance(map, keyPositions, startPosition)
}