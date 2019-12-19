package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(8, manyWorldsInterpretation(listOf("#######       #######", "#a.#Cd#", "##...##", "##.@.##", "##...##", "#cB#Ab#", "#######")))
            checkEquals(24, manyWorldsInterpretation(listOf("###############", "#d.ABC.#.....a#", "######   ######", "###### @ ######", "######   ######", "#b.....#.....c#", "###############")))
            checkEquals(32, manyWorldsInterpretation(listOf("#############", "#DcBa.#.GhKl#", "#.###   #I###", "#e#d# @ #j#k#", "###C#   ###J#", "#fEbA.#.FgHi#", "#############")))
            checkEquals(72, manyWorldsInterpretation(listOf("#############", "#g#f.D#..h#l#", "#F###e#E###.#", "#dCba   BcIJ#", "##### @ #####", "#nK.L   G...#", "#M###N#H###.#", "#o#m..#i#jk.#", "#############")))
        }

        fun checkEquals(expected: Int, actual: Int) {
            check(expected == actual) { "Expected '$expected' but got '$actual'." }
        }
    }
}
