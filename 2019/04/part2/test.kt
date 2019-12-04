package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(true, isValidPassword(112233))
            checkEquals(false, isValidPassword(123444))
            checkEquals(true, isValidPassword(111122))
        }

        fun checkEquals(expected: Boolean, actual: Boolean) {
            check(expected == actual) { "Expected '$expected' but got '$actual'." }
        }
    }
}
