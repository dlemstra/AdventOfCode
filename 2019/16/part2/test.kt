package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(84462026, flawedFrequencyTransmission("03036732577212944063491565474664"))
            checkEquals(78725270, flawedFrequencyTransmission("02935109699940807407585447034323"))
            checkEquals(53553731, flawedFrequencyTransmission("03081770884921959731165446850517"))
        }

        fun checkEquals(expected: Int, actual: Int) {
            check(expected == actual) { "Expected '$expected' but got '$actual'." }
        }
    }
}
