package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(966, theTyrannyOfTheRocketEquation(arrayOf("1969").asSequence()))
            checkEquals(50346, theTyrannyOfTheRocketEquation(arrayOf("100756").asSequence()))
        }

    fun checkEquals(expected: Number, actual: Number) {
        check(expected == actual) { "Expected '$expected' but got '$actual'." }
    }
    }
}
