import 'dart:io';

enum Operation {
    plus,
    minus,
    divide,
    multiply
}

String? operationValue(Operation? operation) {
    switch(operation) {
        case null: return null;
        case Operation.plus: return "+";
        case Operation.minus: return "-";
        case Operation.divide: return "/";
        case Operation.multiply: return "*";
    }
}

class Monkey {
    final String name;
    int value = 0;
    bool done = false;
    String? left;
    Operation? operation;
    String? right;

    Monkey(this.name);

    void yell(List<Monkey> monkeys) {
        if (done) return;

        final a = monkeys.firstWhere((monkey) => monkey.name == left);
        if (!a.done) return;

        final b = monkeys.firstWhere((monkey) => monkey.name == right);
        if (!b.done) return;

        switch(operation) {
            case Operation.plus: value = a.value + b.value; break;
            case Operation.minus: value = a.value - b.value; break;
            case Operation.divide: value = (a.value / b.value).floor(); break;
            case Operation.multiply: value = a.value * b.value; break;
        }

        done = true;
    }

    @override
    String toString()
        => "${name} = ${value} ${left ?? ""} ${operationValue(operation) ?? ""} ${right ?? ""}".trim();
}

List<Monkey> loadMonkeys(List<String> lines) {
    final result = <Monkey>[];
    for (var line in lines) {
        var info = line.split(": ");
        final monkey = new Monkey(info[0]);
        final value = int.tryParse(info[1]);
        if (value != null) {
            monkey.value = value;
            monkey.done = true;
        } else {
            info = info[1].split(" ");
            monkey.left = info[0];
            monkey.right = info[2];
            switch(info[1]) {
                case "+": monkey.operation = Operation.plus; break;
                case "-": monkey.operation = Operation.minus; break;
                case "/": monkey.operation = Operation.divide; break;
                case "*": monkey.operation = Operation.multiply; break;
            }
        }

        result.add(monkey);
    }

    return result;
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    final monkeys = loadMonkeys(lines);

    final monkeysWithOperation = List<Monkey>.from(monkeys);
    monkeysWithOperation.retainWhere((monkey) => monkey.operation != null);
    monkeysWithOperation.sort((a, b) => a.left == b || a.right == b ? -1 : 1);

    final root = monkeysWithOperation.firstWhere((monkey) => monkey.name == "root");
    while (!root.done) {
        for (final monkey in monkeysWithOperation) {
            monkey.yell(monkeys);
        }
    }

    print(root.value);
}
