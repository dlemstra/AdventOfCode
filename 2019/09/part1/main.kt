package aoc

import java.io.File

fun main(args: Array<String>) {
    val lines = File("../input").readLines()

    println(sensorBoost(lines.first()))
}