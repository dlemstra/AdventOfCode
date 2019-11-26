package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals("Hello World", helloWorld(arrayOf("Hello World").asSequence()))
        }

    fun checkEquals(expected: String, actual: String) {
        check(expected == actual) { "Expected '$expected' but got '$actual'." }
    }
    }
}
