import 'dart:io';

class Monkey {
    List<int> items = [];
    bool multiplication = false;
    int value = 0;
    int diviser = 0;
    int trueTarget = 0;
    int falseTarget = 0;
    int inspected = 0;

    int getNextValue() {
        this.inspected++;

        final result = this.items.removeAt(0);
        final value = this.value == -1 ? result : this.value;
        if (this.multiplication) {
            return result * value;
        }

        return result + value;
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

void solve(List<String> lines, bool divideByThree, int rounds) {
    final monkeys = loadMonkeys(lines);
    final diviserProduct = monkeys.fold(1, (acc, monkey) => acc * monkey.diviser);

    while (rounds-- != 0) {
        for (final monkey in monkeys) {
            while (monkey.items.length > 0) {
                var nextValue = monkey.getNextValue();
                if (divideByThree) {
                    nextValue = nextValue ~/ 3;
                } else {
                    nextValue %= diviserProduct;
                }

                final target = nextValue % monkey.diviser == 0 ? monkey.trueTarget : monkey.falseTarget;
                monkeys[target].items.add(nextValue);
            }
        }
    }

    var inspectCounts = monkeys.map((m) => m.inspected).toList();
    inspectCounts.sort();

    print(inspectCounts.removeLast() * inspectCounts.removeLast());
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines, true, 20);
    solve(lines, false, 10000);
}
