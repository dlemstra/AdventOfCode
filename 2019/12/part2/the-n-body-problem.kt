package aoc

import kotlin.math.abs

data class Point(var x: Int, var y: Int, var z: Int)

class Moon(x: Int, y: Int, z: Int) {
    val pos = Point(x, y, z)
    val vel = Point(0, 0, 0)
    val start = Point(x, y, z)

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

    fun atStartX(): Int = if (pos.x == start.x) 1 else 0

    fun atStartY(): Int = if (pos.y == start.y) 1 else 0

    fun atStartZ(): Int = if (pos.z == start.z) 1 else 0

    override fun toString() = "pos=<x=${pos.x}, y=${pos.y}, z=${pos.z}>, vel=<x=${vel.x}, y=${vel.y}, z=${vel.z}>"
}

fun applyGravity(moons: List<Moon>) {
    for (i in (0..moons.count()-1))
        for (j in (0..moons.count()-1))
            if (i != j)
                moons[i].applyGravity(moons[j])
}

fun greatestCommonDivisor(a: Long, b: Long) : Long {
    var aa = abs(a);
    var bb = abs(b);

    while (true) {
        val remainder = aa % bb;
        if (remainder == 0L)
            return bb
        aa = bb;
        bb = remainder
    }
}

fun leastCommonMultiple(a: Long, b: Long): Long =  (a / greatestCommonDivisor(a, b)) * b

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

fun theNBodyProblem(data: List<String>): Long {
    val moons = readMoons(data)

    var stepsX = 0L
    var stepsY = 0L
    var stepsZ = 0L

    var steps = 1L
    while (true) {
        applyGravity(moons)
        moons.forEach{ it.addVelocity() }
        steps++

        if (stepsX == 0L) {
            if (moons.map{ it.atStartX() }.sum() == moons.count() && moons.map{ it.vel.x }.sum() == 0)
                stepsX = steps
        }

        if (stepsY == 0L) {
            if (moons.map{ it.atStartY() }.sum() == moons.count() && moons.map{ it.vel.y }.sum() == 0)
                stepsY = steps
        }

        if (stepsZ == 0L) {
            if (moons.map{ it.atStartZ() }.sum() == moons.count() && moons.map{ it.vel.z }.sum() == 0)
                stepsZ = steps
        }

        if (stepsX > 0 && stepsY > 0 && stepsZ > 0)
            break
    }

    return leastCommonMultiple(leastCommonMultiple(stepsX, stepsY), stepsZ)
}