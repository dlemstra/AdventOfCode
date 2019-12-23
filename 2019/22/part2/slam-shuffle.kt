package aoc

import java.math.BigInteger

fun Long.toBigInteger() = BigInteger(this.toString())

fun Int.toBigInteger() = BigInteger(this.toString())

fun slamShuffle(data: List<String>): Long {
    val count = 119315717514047.toBigInteger()
    val times = 101741582076661.toBigInteger()
    val index = 2020.toBigInteger()
    val one = 1.toBigInteger()

    fun inv(value: BigInteger): BigInteger = value.modPow(count - 2.toBigInteger(), count)

    // I have no clue what is happening down below... I hope you understand it...
    var offset = 0.toBigInteger()
    var increment = one
    for (method in data) {
        if (method == "deal into new stack") {
            offset -= increment
            increment *= -1.toBigInteger()
        } else if (method.startsWith("deal with increment")) {
            val inc = BigInteger(method.substring(20))
            increment *= inv(inc)
        } else if (method.startsWith("cut")) {
            var cut = BigInteger(method.substring(4))
            offset += increment * cut
        }
    }

    offset *= inv(one - increment);
    increment = increment.modPow(times, count)
    return ((index * increment + (one - increment) * offset).mod(count)).toLong()
}