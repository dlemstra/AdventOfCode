import 'dart:io';

int findEndIndex(String line) {
    var depth = 1;
    for (var i = 0; i < line.length; i++) {
        if (line[i] == "[") {
            depth++;
        } else if (line[i] == "]") {
            if (--depth == 0) {
                return i + 1;
            }
        }
    }

    return line.length - 1;
}

List createList(String line) {
    final result = [];

    var part = "";
    for (var i = 0; i < line.length; i++) {
        if (line[i] == "[") {
            final startIndex = i + 1;
            final endIndex = findEndIndex(line.substring(startIndex));
            final list = createList(line.substring(startIndex, endIndex + startIndex - 1));
            result.add(list);
            i = endIndex + startIndex;
        } else if (line[i] == ",") {
            if (part != "") {
                result.add(int.parse(part));
            }
            part = "";
        } else if (line[i] != "]") {
            part += line[i];
        }
    }
    if (part != "") {
        result.add(int.parse(part));
    }

    return result;
}

bool? isCorrectOrder(dynamic valueA, dynamic valueB) {
    if (valueA is int && valueB is List) {
        return isCorrectOrder([valueA], valueB);
    } else if (valueA is List && valueB is int) {
        return isCorrectOrder(valueA, [valueB]);
    } else if (valueA is List && valueB is List) {
        while (valueA.length > 0 && valueB.length > 0) {
            final correctOrder = isCorrectOrder(valueA.removeAt(0), valueB.removeAt(0));
            if (correctOrder != null) {
                return correctOrder;
            }
        }
        return isCorrectOrder(valueA.length, valueB.length);
    } else if (valueA == valueB) {
        return null;
    }

    return valueA < valueB;
}

void solve(List<String> lines) {
    var part1 = 0;
    for (var i = 0; i < lines.length; i += 3) {
        final listA = createList(lines[i].substring(1, lines[i].length - 1));
        final listB = createList(lines[i + 1].substring(1, lines[i + 1].length - 1));

        if (isCorrectOrder(listA, listB) == true) {
            part1 += (i + 3) ~/ 3;
        }
    }

    print(part1);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
