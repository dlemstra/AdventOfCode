package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(2, programAlarm("1,0,0,0,99"))
            checkEquals(3500, programAlarm("1,9,10,3,2,3,11,0,99,30,40,50"))
            checkEquals(2, programAlarm("2,3,0,3,99"))
            checkEquals(2, programAlarm("2,4,4,5,99,0"))
            checkEquals(30, programAlarm("1,1,1,4,99,5,6,0,99"))
        }

        fun checkEquals(expected: Int, actual: Int) {
            check(expected == actual) { "Expected '$expected' but got '$actual'." }
        }
    }
}
