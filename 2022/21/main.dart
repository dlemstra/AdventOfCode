import 'dart:io';

enum Operation {
    plus,
    minus,
    divide,
    multiply,
    equal
}

class Monkey {
    final String name;
    double value = 0;
    bool done = false;
    String? leftName;
    String? rightName;
    Operation? operation;
    Monkey? left;
    Monkey? right;

    Monkey(this.name);

    void init(List<Monkey> monkeys) {
        if (operation != null) {
            left = monkeys.firstWhere((monkey) => monkey.name == leftName);
            right = monkeys.firstWhere((monkey) => monkey.name == rightName);
        }
        reset();
    }

    void reset() {
        done = operation == null;
        if (!done) value = 0;
    }

    void yell(List<Monkey> monkeys) {
        if (done) return;
        if (!left!.done) return;
        if (!right!.done) return;

        switch(operation) {
            case Operation.plus: value = left!.value + right!.value; break;
            case Operation.minus: value = left!.value - right!.value; break;
            case Operation.divide: value = left!.value / right!.value; break;
            case Operation.multiply: value = left!.value * right!.value; break;
        }

        done = true;
    }
}

List<Monkey> loadMonkeys(List<String> lines) {
    final result = <Monkey>[];
    for (var line in lines) {
        var info = line.split(": ");
        final monkey = new Monkey(info[0]);
        final value = double.tryParse(info[1]);
        if (value != null) {
            monkey.value = value;
        } else {
            info = info[1].split(" ");
            monkey.leftName = info[0];
            monkey.rightName = info[2];
            switch(info[1]) {
                case "+": monkey.operation = Operation.plus; break;
                case "-": monkey.operation = Operation.minus; break;
                case "/": monkey.operation = Operation.divide; break;
                case "*": monkey.operation = Operation.multiply; break;
            }
        }

        result.add(monkey);
    }

    for (var monkey in result) {
        monkey.init(result);
    }

    return result;
}

List<Monkey> getMonkeysWithOperation(List<Monkey> monkeys) {
    final result = List<Monkey>.from(monkeys);
    result.retainWhere((monkey) => monkey.operation != null);
    result.sort((a, b) => a.left == b || a.right == b ? -1 : 1);
    return result;
}

void makeMonkeysYell(List<Monkey> monkeys, Monkey root, List<Monkey> monkeysWithOperation) {
    for (final monkey in monkeysWithOperation) {
        monkey.reset();
    }

    while (!root.done) {
        for (final monkey in monkeysWithOperation) {
            monkey.yell(monkeys);
        }
    }
}

void part1(Monkey root, List<Monkey> monkeys, List<Monkey> monkeysWithOperation) {
    makeMonkeysYell(monkeys, root, monkeysWithOperation);
    print(root.value.floor());
}

void part2(Monkey root, List<Monkey> monkeys, List<Monkey> monkeysWithOperation) {
    makeMonkeysYell(monkeys, root, monkeysWithOperation);

    root.operation = Operation.equal;

    final me = monkeys.firstWhere((monkey) => monkey.name == "humn");

    while (root.left!.value > root.right!.value) {
        me.value = me.value * 2;

        makeMonkeysYell(monkeys, root, monkeysWithOperation);
    }

    var min = me.value / 2;
    var max = me.value;

    while (root.left!.value != root.right!.value) {
        me.value = min + ((max - min) / 2).floor();

        makeMonkeysYell(monkeys, root, monkeysWithOperation);

        if (root.left!.value > root.right!.value) {
            min = me.value;
        } else {
            max = me.value;
        }
    }

    print(me.value.floor());
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    final monkeys = loadMonkeys(lines);
    final monkeysWithOperation = getMonkeysWithOperation(monkeys);
    final root = monkeys.firstWhere((monkey) => monkey.name == "root");

    part1(root, monkeys, monkeysWithOperation);
    part2(root, monkeys, monkeysWithOperation);
}
