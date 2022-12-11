import 'dart:io';
import 'dart:math';

class Monkey {
  List<int> items = [];
  bool multiplication = false;
  int value = 0;
  int diviser = 0;
  int trueTarget = 0;
  int falseTarget = 0;
  int inspected = 0;

  int getNextValue() {
    var result = this.items.removeAt(0);
    final value = this.value == -1 ? result : this.value;
    if (this.multiplication) {
        result *= value;
    } else {
        result += value;
    }

    return (result / 3).floor();
  }

  @override
  String toString() {
    return "${this.items} ${this.multiplication} ${this.value} ${this.diviser} ${this.trueTarget} ${this.falseTarget} ${this.inspected}";
  }
}

List<Monkey> loadMonkeys(List<String> lines) {
  final monkeys = <Monkey>[];
  monkeys.add(new Monkey());

  for (var line in lines) {
    if (line.startsWith("  Starting")) {
      monkeys.last.items = line.split(":")[1].split(",").map((v) => int.parse(v)).toList();
    } else if (line.startsWith("  Operation:")) {
      var info = line.split(" ");
      monkeys.last.multiplication = info[6] == "*";
      if (info[7] == "old") {
        monkeys.last.value = -1;
      } else {
        monkeys.last.value = int.parse(info[7]);
      }
    } else if (line.startsWith("  Test:")) {
        monkeys.last.diviser = int.parse(line.split(" ").last);
    } else if (line.startsWith("    If true:")) {
        monkeys.last.trueTarget = int.parse(line.split(" ").last);
    } else if (line.startsWith("    If false:")) {
        monkeys.last.falseTarget = int.parse(line.split(" ").last);
    } else if (line == "") {
        monkeys.add(new Monkey());
    }
  }

  return monkeys;
}

int solve(List<Monkey> monkeys, int rounds) {
    while (rounds-- != 0) {
        for (final monkey in monkeys) {
            while (monkey.items.length > 0) {
                final nextValue = monkey.getNextValue();
                monkeys[nextValue % monkey.diviser == 0 ? monkey.trueTarget : monkey.falseTarget].items.add(nextValue);
                monkey.inspected++;
            }
        }
    }

    var inspectCounts = monkeys.map((m) => m.inspected).toList();
    inspectCounts.sort();

    return inspectCounts.removeLast() * inspectCounts.removeLast();
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  final monkeys = loadMonkeys(lines);
  print(solve(monkeys, 20));
  print(solve(monkeys, 10000));
}
