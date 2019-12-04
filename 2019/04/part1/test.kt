package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(true, isValidPassword(111111))
            checkEquals(false, isValidPassword(223450))
            checkEquals(false, isValidPassword(123789))
        }

        fun checkEquals(expected: Boolean, actual: Boolean) {
            check(expected == actual) { "Expected '$expected' but got '$actual'." }
        }
    }
}
