package aoc

import kotlin.math.abs

class Requirement(val name: String, val count: Int) {
    private var used = 0

    fun addUsed(count: Int) {
        used += count
    }

    fun produced() = count * used

    override fun toString() = "$count $name (${produced()})"
}

class Chemical(name: String, count: String) {
    val name = name
    val count = count.toInt()
    val requirements = mutableListOf<Requirement>()

    fun addRequirement(name: String, count: String) = requirements.add(Requirement(name, count.toInt()))

    override fun toString() = "$count $name $requirements"
}

fun addUsed(requirement: Requirement, count: Int, chemicals: Map<String, Chemical>, remaining: MutableMap<String, Int>) {
    if (!chemicals.containsKey(requirement.name))
        return

    var chemical = chemicals[requirement.name] !!

    var used = 0
    var required = (requirement.count * count) - remaining[requirement.name]!!
    remaining[requirement.name] = 0
    while (required > 0) {
        used++
        required -= chemical.count
    }

    if (required != 0)
        remaining[requirement.name] = remaining[requirement.name]!! + abs(required)

    for (newRequirement in chemical.requirements) {
        newRequirement.addUsed(used)
        addUsed(newRequirement, used, chemicals, remaining)
    }
 }

 fun getTotal(chemicals: Map<String, Chemical>): Int {
    var remaining = mutableMapOf<String, Int>()
    for (chemicalName in chemicals.keys) {
        remaining[chemicalName] = 0
    }

    addUsed(Requirement("FUEL", 1), 1, chemicals, remaining)

    return chemicals.values.map{ it.requirements.filter{ it.name == "ORE" }.map{ it.produced() }.sum() }.sum()
 }

fun spaceStoichiometry(data: List<String>): Int {

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