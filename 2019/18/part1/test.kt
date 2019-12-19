package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(8, manyWorldsInterpretation(listOf("#########", "#b.A.@.a#", "#########")))
            checkEquals(86, manyWorldsInterpretation(listOf("########################", "#f.D.E.e.C.b.A.@.a.B.c.#", "######################.#", "#d.....................#", "########################")))
            checkEquals(132, manyWorldsInterpretation(listOf("########################", "#...............b.C.D.f#", "#.######################", "#.....@.a.B.c.d.A.e.F.g#", "########################")))
            checkEquals(136, manyWorldsInterpretation(listOf("#################", "#i.G..c...e..H.p#", "########.########", "#j.A..b...f..D.o#", "########@########", "#k.E..a...g..B.n#", "########.########", "#l.F..d...h..C.m#", "#################")))
            checkEquals(81, manyWorldsInterpretation(listOf("########################", "#@..............ac.GI.b#", "###d#e#f################", "###A#B#C################", "###g#h#i################", "########################")))
        }

        fun checkEquals(expected: Int, actual: Int) {
            check(expected == actual) { "Expected '$expected' but got '$actual'." }
        }
    }
}
