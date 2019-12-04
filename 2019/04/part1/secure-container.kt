package aoc

fun isValidPassword(number: Int): Boolean {
    val password = number.toString()
    val numbers = password.toList().map{ it.toString().toInt() }

    if (numbers.distinct().count() == password.count())
        return false

    for (i in 1..password.count() - 1) {
        if (numbers[i-1] > numbers[i])
            return false
    }

    return true
}

fun secureContainer(start: Int, end: Int): Int {
    var count = 0
    for (i in start..end) {
        if (isValidPassword(i))
            count++
    }

    return count
}