package aoc

fun getValue(values: List<Int>, startIndex: Int, count: Int): Int = values.subList(startIndex, count).joinToString("").toInt()

fun flawedFrequencyTransmission(data: String): Int {
    var values = data.repeat(10000).map{ it.toInt() - 48 }.toMutableList()

    val offset = getValue(values, 0, 7)
    values = values.subList(offset, values.count())

    var total = values.sum()

    for (phase in (1..100)) {

        var newTotal = 0
        for (i in (0..values.lastIndex)) {
            val newValue = total % 10
            total -= values[i]
            values[i] = newValue
            newTotal += newValue
        }

        total = newTotal
    }

    return getValue(values, 0, 8)
}