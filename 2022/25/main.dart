import 'dart:io';
import 'dart:math';

int snafuToInt(String snafu) {
    var value = 0;
    for (var i = 0; i < snafu.length; i++) {
        final number = pow(5, snafu.length - i - 1) as int;
        switch (snafu[i]) {
            case "2": value += 2 * number; break;
            case "=": value += -2 * number; break;
            case "-": value += -1 * number; break;
            case "1": value += number; break;
        }
    }
    return value;
}

String intToSnafu(int value) {
    var exponent = (log(value) / log(5)).floor();

    var snafu = "";
    while (value > snafuToInt(snafu)) {
        snafu = "";
        for (var i = 0; i < exponent - 1; i++) {
            snafu += "2";
        }
        exponent++;
    }

    for (var i = 0; i < snafu.length; i++) {
        for (var char in ["2", "1", "0", "-", "="]) {
            var newSnafu = snafu.substring(0, i) + char + snafu.substring(i + 1);
            if (snafuToInt(newSnafu) < value) break;
            snafu = newSnafu;
        }
    }

    return snafu;
}

solve(List<String> lines) {
    var total = 0;
    for (final line in lines) {
        total += snafuToInt(line);
    }
    print(intToSnafu(total));
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
