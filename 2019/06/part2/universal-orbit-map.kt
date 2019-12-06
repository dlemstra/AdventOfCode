package aoc

import kotlin.math.min

fun findShortestPath(orbits: Map<String, List<String>>, prev: List<String>, start: String, end: String): Int {
   var minDistance = Int.MAX_VALUE

   if (prev.contains(start))
      return minDistance

   val planets = orbits[start].orEmpty()
   if (planets.contains(end))
      return prev.count() - 1

   var newPrev = prev.toMutableList();
   newPrev.add(start)

   for (planet in planets) {
      minDistance = min(minDistance,findShortestPath(orbits, newPrev, planet, end))
   }

   return minDistance
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
      addPlanets(orbits, info[1], info[0])
   }

   return findShortestPath(orbits, mutableListOf<String>(), "YOU", "SAN")
}
