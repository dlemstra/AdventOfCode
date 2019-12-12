package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(179, theNBodyProblem(listOf("<x=-1, y=0, z=2>", "<x=2, y=-10, z=-7>", "<x=4, y=-8, z=8>", "<x=3, y=5, z=-1>"), 10))
            checkEquals(1940, theNBodyProblem(listOf("<x=-8, y=-10, z=0>", "<x=5, y=5, z=10>", "<x=2, y=-7, z=3>", "<x=9, y=-8, z=-3>"), 100))
        }

        fun checkEquals(expected: Int, actual: Int) {
            check(expected == actual) { "Expected '$expected' but got '$actual'." }
        }
    }
}
