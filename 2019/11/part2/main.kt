package aoc

import java.io.File

fun main(args: Array<String>) {
    val data = File("../input").readLines()

    spacePolice(data.first())
}