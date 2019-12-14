package aoc

import kotlin.math.abs

data class Requirement(val name: String, var count: Long)

class Chemical(name: String, count: String) {
    val name = name
    var count = count.toLong()
    val requirements = mutableListOf<Requirement>()

    fun addRequirement(name: String, count: String) = requirements.add(Requirement(name, count.toLong()))
}

fun getTotal(requirement: Requirement, count: Long, chemicals: Map<String, Chemical>, remaining: MutableMap<String, Long>): Long {
    var chemical = chemicals[requirement.name] !!

    var required = (requirement.count * count) - remaining[requirement.name] !!

    var used = 1L
    if (chemical.count > required) {
        remaining[requirement.name] = chemical.count - required
    } else {
        used = required / chemical.count
        val remainder = required % chemical.count
        remaining[requirement.name] = remainder
        if (remainder != 0L) {
            used++
            remaining[requirement.name] = chemical.count - remainder
        }
    }

    var total = 0L
    for (newRequirement in chemical.requirements) {
        if (newRequirement.name == "ORE")
            return (used * newRequirement.count)

        total += getTotal(newRequirement, used, chemicals, remaining)
    }

    return total
 }

 fun getTotal(chemicals: Map<String, Chemical>): Long {
    var remaining = mutableMapOf<String, Long>()
    for (chemicalName in chemicals.keys) {
        remaining[chemicalName] = 0
    }

    var count = 0L
    var total = 0L
    while (total < 1000000000000L) {
        count += 1000
        total = getTotal(Requirement("FUEL", count), 1, chemicals, remaining.toMutableMap())
    }

    while (total > 1000000000000L)
        total = getTotal(Requirement("FUEL", --count), 1, chemicals, remaining.toMutableMap())

    return count
 }

fun spaceStoichiometry(data: List<String>): Long {

    var chemicals = mutableMapOf<String, Chemical>()

    for (line in data) {
        val info = line.split(" => ")
        val inputs = info[0].split(", ")
        val output = info[1].split(" ")

        val name = output[1];
        val chemical = Chemical(name, output[0])
        chemicals[name] = chemical

        for (input in inputs) {
            val requirement = input.split(" ")
            chemical.addRequirement(requirement[1], requirement[0])
        }
    }

    return getTotal(chemicals)
}