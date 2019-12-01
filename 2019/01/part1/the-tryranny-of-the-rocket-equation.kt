package aoc

fun theTyrannyOfTheRocketEquation(input: Sequence<String>): Number {
   var result = 0
   for (line in input) {
      val value = line.toInt()
      result += (value / 3) - 2
   }
   return result
}