import 'dart:io';

class Position {
    final int x;
    final int y;

    Position(this.x, this.y);

    bool operator==(covariant Position other)
        => this.x == other.x && this.y == other.y;

    @override
    int get hashCode
        => Object.hash(this.x, this.y);

    @override
    String toString()
        => "${x}x${y}";
}

class Blizzard {
    Position position;
    final String direction;

    Blizzard(this.position, this.direction);

    move(int maxX, int maxY) {
        position = _nextPosition(maxX, maxY);
    }

    Position _nextPosition(int maxX, int maxY) {
        switch (direction) {
            case ">": return new Position(position.x + 1 > maxX ? 1 : position.x + 1, position.y);
            case "<": return new Position(position.x - 1 < 1 ? maxX : position.x - 1, position.y);
            case "v": return new Position(position.x, position.y + 1 > maxY ? 1 : position.y + 1);
            case "^": return new Position(position.x, position.y - 1 < 1 ? maxY : position.y - 1);
            default: throw Exception(direction);
        }
    }
}

class State {
    final Position position;
    final int minute;

    State(this.position, this.minute);

    List<State> nextStates(Map<int, Set<Position>> blizzardPositions, int maxX, int maxY) {
        final states = <State>[];

        final blizzards = blizzardPositions[(minute + 1) % blizzardPositions.length]!;
        for (final newPosition in [new Position(position.x - 1, position.y),
                                   new Position(position.x + 1, position.y),
                                   new Position(position.x, position.y - 1),
                                   new Position(position.x, position.y + 1),
                                   new Position(position.x, position.y)]) {
            if (_validPosition(newPosition, blizzards, maxX, maxY))
                states.add(new State(newPosition, minute + 1));
        }

        return states;
    }

    bool _validPosition(Position position, Set<Position> blizzards, int maxX, int maxY)
        => (!blizzards.contains(position) &&
            position.x >= 1 && position.x <= maxX &&
            position.y >= 1 && position.y <= maxY) ||
           (position.x == 1 && position.y == 0) ||
           (position.x == maxX && position.y == maxY + 1);
}

int duration(State start, Position end, Map<int, Set<Position>> blizzardPositions, int maxX, int maxY) {
    final visited = new Set<String>();
    final stack = List<State>.from([start]);
    while (stack.length != 0) {
        final state = stack.removeAt(0);
        if (state.position.x == end.x && state.position.y == end.y) {
            return state.minute;
        }

        if (visited.add("${state.position} ${state.minute}"))
            stack.addAll(state.nextStates(blizzardPositions, maxX, maxY));
    }

    throw new Exception();
}

int lcm(int a, int b)
    => (a * b) ~/ gcd(a, b);

int gcd(int a, int b) {
    while (b != 0) {
        final t = b;
        b = a % t;
        a = t;
    }
    return a;
}

solve(List<String> lines) {
    final blizzards = <Blizzard>[];

    var y = 0;
    for (final line in lines) {
        for (var x = 0; x < line.length; x++) {
            if (line[x] == '>' || line[x] == '<' || line[x] == '^' || line[x] == 'v') {
                blizzards.add(new Blizzard(new Position(x, y), line[x]));
            }
        }
        y++;
    }

    final maxX = lines[0].length - 2;
    final maxY = lines.length - 2;

    final blizzardPositions = new Map<int, Set<Position>>();
    final maxMinute = lcm(maxX, maxY);
    var minute = 0;
    while (minute < maxMinute) {
        blizzardPositions[minute++] = blizzards.map((blizzard) => blizzard.position).toSet();
        for (final blizzard in blizzards) {
            blizzard.move(maxX, maxY);
        }
    }

    var minutes = duration(new State(new Position(1, 0), 0), new Position(maxX, maxY), blizzardPositions, maxX, maxY);
    print(++minutes);
    minutes = duration(new State(new Position(maxX, maxY + 1), minutes), new Position(1, 1), blizzardPositions, maxX, maxY);
    minutes = duration(new State(new Position(1, 0), minutes + 1), new Position(maxX, maxY), blizzardPositions, maxX, maxY);
    print(++minutes);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
