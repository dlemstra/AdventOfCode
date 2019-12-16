package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(24176176, flawedFrequencyTransmission("80871224585914546619083218645595"))
            checkEquals(73745418, flawedFrequencyTransmission("19617804207202209144916044189917"))
            checkEquals(52432133, flawedFrequencyTransmission("69317163492948606335995924319873"))
        }

        fun checkEquals(expected: Int, actual: Int) {
            check(expected == actual) { "Expected '$expected' but got '$actual'." }
        }
    }
}
