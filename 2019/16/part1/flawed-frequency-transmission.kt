package aoc

import kotlin.math.abs

fun flawedFrequencyTransmission(data: String): Int {
    val values = data.map{ it.toInt() - 48 }.toMutableList()
    for (phase in (1..100)) {

        var multiplier = 1
        for (i in (0..values.lastIndex)) {
            var result = 0

            var k = 0
            var j = i
            val stepSize = j + 1
            while (j < values.count()) {
                result += values[j] * multiplier
                if (++k == stepSize) {
                    k = 0
                    j += stepSize + 1
                    multiplier *= -1
                    continue
                }
                j++
            }

            result = abs(result % 10)
            values[i] = result
        }
    }

    return values.subList(0, 8).joinToString("").toInt()
}