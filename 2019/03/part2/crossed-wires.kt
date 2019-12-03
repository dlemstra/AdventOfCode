package aoc

import kotlin.math.min

data class Position(val x: Int, val y: Int)

fun getPositions(input: String): List<Position> {
    var result = mutableListOf<Position>();

    var x = 0;
    var y = 0;

    val movements = input.split(",").map{ it.trim() }
    for (movement in movements) {
        val direction = movement[0]
        val steps = movement.substring(1).toInt()
        for (i in 0 until steps) {
            when (direction) {
                'R' -> x++
                'L' -> x--
                'D' -> y++
                'U' -> y--
            }
            result.add(Position(x, y))
        }
    }

    return result;
}

fun crossedwWires(input: List<String>): Int {
    val positions1 = getPositions(input[0]);
    val positions2 = getPositions(input[1]);

    val intersections = positions1.intersect(positions2)

    var minSteps = Int.MAX_VALUE
    for (intersection in intersections) {
        val steps1 = positions1.indexOf(intersection) + 1
        val steps2 = positions2.indexOf(intersection) + 1
        minSteps = min(steps1 + steps2, minSteps)
    }

    return minSteps
}