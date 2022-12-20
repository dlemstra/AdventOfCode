import 'dart:io';

// Trick to handle duplicate values
class Value {
    final int number;
    Value(this.number);
}

void solve(List<String> lines) {
    final original = lines.map(int.parse).map(Value.new).toList();
    final items = List<Value>.from(original);
    final length = items.length - 1;

    for (var value in original) {
        final index = items.indexOf(value);
        items.removeAt(index);
        items.insert((index + value.number) % length, value);
    }
    final zeroIndex = items.indexWhere((item) => item.number == 0);
    var part1 = items[(zeroIndex + 1000) % items.length].number;
    part1 += items[(zeroIndex + 2000) % items.length].number;
    part1 += items[(zeroIndex + 3000) % items.length].number;
    print(part1);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
