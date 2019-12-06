package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(4, universalOrbitMap(arrayOf("COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L", "K)YOU", "I)SAN").asSequence()))
        }

        fun checkEquals(expected: Number, actual: Number) {
            check(expected == actual) { "Expected '$expected' but got '$actual'." }
        }
    }
}
