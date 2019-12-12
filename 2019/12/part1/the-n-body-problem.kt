package aoc

import kotlin.math.abs

data class Point(var x: Int, var y: Int, var z: Int)

class Moon(x: Int, y: Int, z: Int) {
    val pos = Point(x, y, z)
    val vel = Point(0, 0, 0)

    fun applyGravity(other: Moon) {
        if (other.pos.x != pos.x)
            vel.x += if (other.pos.x > pos.x) 1 else -1
        if (other.pos.y != pos.y)
            vel.y += if (other.pos.y > pos.y) 1 else -1
        if (other.pos.z != pos.z)
            vel.z += if (other.pos.z > pos.z) 1 else -1
    }

    fun addVelocity() {
        pos.x += vel.x
        pos.y += vel.y
        pos.z += vel.z
    }

    fun energy() : Int = (abs(pos.x) + abs(pos.y) + abs(pos.z)) * (abs(vel.x) + abs(vel.y) + abs(vel.z))

    override fun toString() = "pos=<x=${pos.x}, y=${pos.y}, z=${pos.z}>, vel=<x=${vel.x}, y=${vel.y}, z=${vel.z}>"
}

fun applyGravity(moons: List<Moon>) {
    for (i in (0..moons.count()-1))
        for (j in (0..moons.count()-1))
            if (i != j)
                moons[i].applyGravity(moons[j])
}

fun readMoons(data: List<String>) : List<Moon> {
    val moons = mutableListOf<Moon>()
    for (line in data) {
        val info = line.replace("<", "").replace(">", "").split(", ")
        val x = info[0].substring(2).toInt()
        val y = info[1].substring(2).toInt()
        val z = info[2].substring(2).toInt()
        moons.add(Moon(x, y, z))
    }

    return moons
}

fun theNBodyProblem(data: List<String>, steps: Int = 1000): Int {
    val moons = readMoons(data)

    for (i in (1..steps)) {
        applyGravity(moons)
        moons.forEach{ it.addVelocity() }
    }

    return moons.map{ it.energy() }.sum()
}