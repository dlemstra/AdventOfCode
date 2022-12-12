import 'dart:io';

class Step {
    int x = 0;
    int y = 0;
    int count = 0;

    Step(int x, int y) {
        this.x = x;
        this.y = y;
    }

    Step.clone(Step other) {
        x = other.x;
        y = other.y;
        count = other.count;
    }
}

List loadMaze(List<String> lines) {
    final maze = new Map();
    var start;
    var y = 0;
    for (final line in lines) {
        var x = 0;
        for (var rune in line.runes) {
            if (rune == "S".runes.first) {
                rune = 666;
                start = new Step(x, y);
            }

            maze["${x}x${y}"] = rune;
            x++;
        }
        y++;
    }

    return [maze, start];
}

Step? getNextStep(Map maze, Step current, int xIncrement, int yIncrement) {
    final nextStep = Step.clone(current);
    nextStep.x += xIncrement;
    nextStep.y += yIncrement;
    nextStep.count++;

    final destination = maze["${nextStep.x}x${nextStep.y}"];
    if (destination == null) {
        return null;
    }

    if (destination - maze["${current.x}x${current.y}"] > 1) {
        return null;
    }

    if (maze["${nextStep.x}x${nextStep.y}"] == "E".runes.first && maze["${current.x}x${current.y}"] != "z".runes.first) {
        return null;
    }

    return nextStep;
}

void solve(List<String> lines) {
    final info = loadMaze(lines);
    final maze = info[0];

    final steps = <Step>[];
    steps.add(info[1]);

    final bestMoves = new Map();

    var part1 = 100000000000;

    while (steps.length > 0) {
        final step = steps.removeLast();
        final position = "${step.x}x${step.y}";

        if (maze[position] == "E".runes.first) {
            if (step.count < part1) {
                part1 = step.count;
            }
            continue;
        }

        if (bestMoves[position] != null && bestMoves[position] <= step.count) {
            continue;
        } else {
            bestMoves[position] = step.count;
        }

        var nextStep = getNextStep(maze, step, 1, 0);
        if (nextStep != null) {
            steps.add(nextStep);
        }

        nextStep = getNextStep(maze, step, -1, 0);
        if (nextStep != null) {
            steps.add(nextStep);
        }

        nextStep = getNextStep(maze, step, 0, 1);
        if (nextStep != null) {
            steps.add(nextStep);
        }

        nextStep = getNextStep(maze, step, 0, -1);
        if (nextStep != null) {
            steps.add(nextStep);
        }
    }

    print(part1);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
