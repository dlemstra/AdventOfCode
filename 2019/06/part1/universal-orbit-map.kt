package aoc

fun findPlanets(orbits: Map<String, List<String>>, planet: String): Int {
   val planets = orbits[planet]
   if (planets == null)
      return 0

   return planets.count() + planets.map{ findPlanets(orbits, it) }.sum()
}

fun addPlanets(orbits: MutableMap<String, MutableList<String>>, planetA: String, planetB: String) {
   val planets = orbits.getOrPut(planetA) { mutableListOf<String>() }
   planets.add(planetB)
}

fun universalOrbitMap(input: Sequence<String>): Number {
   var orbits = mutableMapOf<String, MutableList<String>>()

   for (line in input) {
      val info = line.split(")")

      addPlanets(orbits, info[0], info[1])
   }

   return orbits.map{ findPlanets(orbits, it.key) }.sum()
}
