package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(654 + 33583, theTyrannyOfTheRocketEquation(arrayOf("1969", "100756").asSequence()))
        }

        fun checkEquals(expected: Number, actual: Number) {
            check(expected == actual) { "Expected '$expected' but got '$actual'." }
        }
    }
}
