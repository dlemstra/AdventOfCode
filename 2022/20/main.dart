import 'dart:io';

// Trick to handle duplicate values
class Value {
    final int number;
    Value(this.number);
}

void moveItems(List<Value> original, List<Value> items) {
    final length = items.length - 1;

    for (var value in original) {
        final index = items.indexOf(value);
        items.removeAt(index);
        items.insert((index + value.number) % length, value);
    }
}

void printCoordinateSum(List<Value> items) {
    final zeroIndex = items.indexWhere((item) => item.number == 0);
    var sum = items[(zeroIndex + 1000) % items.length].number;
    sum += items[(zeroIndex + 2000) % items.length].number;
    sum += items[(zeroIndex + 3000) % items.length].number;
    print(sum);
}

void part1(List<String> lines) {
    final original = lines.map(int.parse).map(Value.new).toList();
    final items = List<Value>.from(original);

    moveItems(original, items);
    printCoordinateSum(items);
}

void part2(List<String> lines) {
    final original = lines.map(int.parse).map((value) => value * 811589153).map(Value.new).toList();
    final items = List<Value>.from(original);

    for (var i = 0; i < 10; i++) {
        moveItems(original, items);
    }
    printCoordinateSum(items);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    part1(lines);
    part2(lines);
}
