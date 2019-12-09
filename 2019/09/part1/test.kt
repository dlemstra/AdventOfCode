package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(1219070632396864, sensorBoost("1102,34915192,34915192,7,4,7,99,0"))
            checkEquals(1125899906842624, sensorBoost("104,1125899906842624,99"))
        }

        fun checkEquals(expected: Long, actual: Long) {
            check(expected == actual) { "Expected '$expected' but got '$actual'." }
        }
    }
}
