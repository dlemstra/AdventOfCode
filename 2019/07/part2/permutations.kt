package aoc

fun List<Int>.permutations(): Set<List<Int>> {
    var result = mutableSetOf<List<Int>>()

    fun MutableList<Int>.swap(i: Int, j: Int) {
        val ii = this[i]
        this[i] = this[j]
        this[j] = ii
    }

    fun permute(values: List<Int>, l: Int, r: Int) {
        if (l == r) {
            result.add(values);
        } else {
            var newValues = values.toMutableList()
            for (i in (l..r)) {
                newValues.swap(l, i)
                permute(newValues.toList(), l + 1, r)
                newValues.swap(l, i)
            }
        }
    }

    permute(this, 0, lastIndex)

    return result;
}