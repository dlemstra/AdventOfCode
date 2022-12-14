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
        var i = 0;
        while (i < valueA.length && i < valueB.length) {
            final correctOrder = isCorrectOrder(valueA[i], valueB[i]);
            if (correctOrder != null) {
                return correctOrder;
            }
            i++;
        }
        return isCorrectOrder(valueA.length, valueB.length);
    } else if (valueA == valueB) {
        return null;
    }

    return valueA < valueB;
}

int compareOrder(List a, List b) {
    final result = isCorrectOrder(new List.from(a), new List.from(b));
    return result == null ? 0 : result == true ? -1 : 1;
}

List part1(List<String> lines) {
    var packets = [];

    var part1 = 0;
    for (var i = 0; i < lines.length; i += 3) {
        final listA = createList(lines[i].substring(1, lines[i].length - 1));
        final listB = createList(lines[i + 1].substring(1, lines[i + 1].length - 1));
        packets.addAll([listA, listB]);

        if (isCorrectOrder(listA, listB) == true) {
            part1 += (i + 3) ~/ 3;
        }
    }

    print(part1);

    return packets;
}

void part2(List packets) {
    packets.addAll([[[2]], [[6]]]);
    packets.sort((a, b) => compareOrder(a, b));

    var part2 = 1;
    for (var i = 0; i < packets.length; i++) {
        if (packets[i].length == 1 && packets[i][0] is List && packets[i][0].length == 1 && [2, 6].contains(packets[i][0][0])) {
            part2 *= i + 1;
        }
    }

    print(part2);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    final packets = part1(lines);
    part2(packets);
}
