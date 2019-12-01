package aoc

fun theTyrannyOfTheRocketEquation(input: Sequence<String>): Number {
   var result = 0
   for (line in input) {
      var value = line.toInt()
      while (true) {
         value = (value / 3) - 2
         if (value < 1)
            break
         result += value
      }
   }
   return result
}