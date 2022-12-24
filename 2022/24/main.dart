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

        final blizzards = blizzardPositions[minute]!;
        var newPosition = new Position(position.x - 1, position.y);
        if (_validPosition(newPosition, blizzards, maxX, maxY)) states.add(new State(newPosition, minute + 1));
        newPosition = new Position(position.x + 1, position.y);
        if (_validPosition(newPosition, blizzards, maxX, maxY)) states.add(new State(newPosition, minute + 1));
        newPosition = new Position(position.x, position.y - 1);
        if (_validPosition(newPosition, blizzards, maxX, maxY)) states.add(new State(newPosition, minute + 1));
        newPosition = new Position(position.x, position.y + 1);
        if (_validPosition(newPosition, blizzards, maxX, maxY)) states.add(new State(newPosition, minute + 1));
        newPosition = new Position(position.x, position.y);
        if (newPosition.x == 1 && newPosition.y == 0) states.add(new State(newPosition, minute + 1));
        else if (_validPosition(newPosition, blizzards, maxX, maxY)) states.add(new State(newPosition, minute + 1));

        for (final state in states) {
            state.history.addAll(history);
            state.history.add(this);
        }

        return states;
    }

    bool _validPosition(Position position, Set<Position> blizzards, int maxX, int maxY)
        => position.x >= 1 && position.x <= maxX &&
           position.y >= 1 && position.y <= maxY &&
           !blizzards.contains(position);

    List<State> history = <State>[];
}

printMap(Set<Position> blizzards, Position me, int maxX, int maxY) {
    for (var y = 0; y < maxY + 2; y++) {
        final row = <String>[];
        for (var x = 0; x < maxX + 2; x++) {
            if (x == me.x && y == me.y) row.add("E");
            else if (y == 0 || y == maxY + 1) row.add("#");
            else if (x == 0 || x == maxX + 1) row.add("#");
            else if (blizzards.contains(new Position(x, y))) row.add("*");
            else row.add(" ");
        }
        print(row.join());
    }
    print("");
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

    final states = new Map<int, Set<Position>>();
    final maxMinute = maxX * maxY;
    var minute = -1;
    while (minute <= maxMinute) {
        states[minute++] = blizzards.map((blizzard) => blizzard.position).toSet();
        for (final blizzard in blizzards) {
            blizzard.move(maxX, maxY);
        }
    }

    final visited = new Set<String>();

    final stack = List<State>.from([new State(new Position(1, 0), 0)]);
    while (stack.length != 0) {
        final state = stack.removeAt(0);
        if (state.position.x == maxX && state.position.y == maxY) {
            print("${state.minute + 1}");
            return;
        }

        if (!visited.add("${state.position} ${state.minute}")) continue;
        stack.addAll(state.nextStates(states, maxX, maxY));
    }
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
