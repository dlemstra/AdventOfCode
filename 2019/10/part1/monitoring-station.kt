package aoc

class Line(a: Astroid, b: Astroid) {
    private val a = a
    private val b = b

    fun blockedBy(c: Astroid): Boolean {
        val crossproduct = (c.y - a.y) * (b.x - a.x) - (c.x - a.x) * (b.y - a.y)

        if (crossproduct != 0)
            return false

        val dotproduct = (c.x - a.x) * (b.x - a.x) + (c.y - a.y)*(b.y - a.y)
        if (dotproduct < 0)
            return false

        val squaredlengthba = (b.x - a.x)*(b.x - a.x) + (b.y - a.y)*(b.y - a.y)
        if (dotproduct > squaredlengthba)
            return false

        return true
    }
}

class Astroid(val x: Int, val y: Int) {
    val detectedAstroids = mutableListOf<Astroid>()

    fun addIfVisible(astroid: Astroid, astroids: List<Astroid>) {
        if (visible(astroid, astroids))
            detectedAstroids.add(astroid)
    }

    override fun toString() = "$x,$y"

    private fun visible(astroid: Astroid, astroids: List<Astroid>): Boolean {
        val line = Line(this, astroid)
        for (other in astroids)
            if (other != this && other != astroid)
                if (line.blockedBy(other))
                    return false

        return true
    }
}

fun loadAstroids(input: List<String>): List<Astroid> {
    val result = mutableListOf<Astroid>()

    var y = 0
    for (line in input) {
        var x = 0
        for (char in line) {
            if (char == '#')
                result.add(Astroid(x, y))
            x++
        }
        y++
    }

    return result
}

fun monitoringStation(input: List<String>): Int {
    val astroids = loadAstroids(input)

    for (astroid in astroids)
        for (other in astroids)
            if (astroid != other)
                astroid.addIfVisible(other, astroids)

    return astroids.map{ it.detectedAstroids.count() }.max() !!
}