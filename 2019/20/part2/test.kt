package aoc

import kotlin.check

class test() {
    companion object {
        @JvmStatic fun main(args: Array<String>) {
            checkEquals(26, donutMaze(listOf("         A           ", "         A           ", "  #######.#########  ", "  #######.........#  ", "  #######.#######.#  ", "  #######.#######.#  ", "  #######.#######.#  ", "  #####  B    ###.#  ", "BC...##  C    ###.#  ", "  ##.##       ###.#  ", "  ##...DE  F  ###.#  ", "  #####    G  ###.#  ", "  #########.#####.#  ", "DE..#######...###.#  ", "  #.#########.###.#  ", "FG..#########.....#  ", "  ###########.#####  ", "             Z       ", "             Z       ")))
            checkEquals(396, donutMaze(listOf("             Z L X W       C                 ", "             Z P Q B       K                 ", "  ###########.#.#.#.#######.###############  ", "  #...#.......#.#.......#.#.......#.#.#...#  ", "  ###.#.#.#.#.#.#.#.###.#.#.#######.#.#.###  ", "  #.#...#.#.#...#.#.#...#...#...#.#.......#  ", "  #.###.#######.###.###.#.###.###.#.#######  ", "  #...#.......#.#...#...#.............#...#  ", "  #.#########.#######.#.#######.#######.###  ", "  #...#.#    F       R I       Z    #.#.#.#  ", "  #.###.#    D       E C       H    #.#.#.#  ", "  #.#...#                           #...#.#  ", "  #.###.#                           #.###.#  ", "  #.#....OA                       WB..#.#..ZH", "  #.###.#                           #.#.#.#  ", "CJ......#                           #.....#  ", "  #######                           #######  ", "  #.#....CK                         #......IC", "  #.###.#                           #.###.#  ", "  #.....#                           #...#.#  ", "  ###.###                           #.#.#.#  ", "XF....#.#                         RF..#.#.#  ", "  #####.#                           #######  ", "  #......CJ                       NM..#...#  ", "  ###.#.#                           #.###.#  ", "RE....#.#                           #......RF", "  ###.###        X   X       L      #.#.#.#  ", "  #.....#        F   Q       P      #.#.#.#  ", "  ###.###########.###.#######.#########.###  ", "  #.....#...#.....#.......#...#.....#.#...#  ", "  #####.#.###.#######.#######.###.###.#.#.#  ", "  #.......#.......#.#.#.#.#...#...#...#.#.#  ", "  #####.###.#####.#.#.#.#.###.###.#.###.###  ", "  #.......#.....#.#...#...............#...#  ", "  #############.#.#.###.###################  ", "               A O F   N                     ", "               A A D   M                     ")))
        }

        fun checkEquals(expected: Int, actual: Int) {
            check(expected == actual) { "Expected '$expected' but got '$actual'." }
        }
    }
}
