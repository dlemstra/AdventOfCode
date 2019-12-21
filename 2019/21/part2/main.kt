package aoc

import java.io.File

fun main(args: Array<String>) {
    val data = File("../input").readLines()
    val input = File("./input").readLines()

    tractorBeam(data.first(), input)
}