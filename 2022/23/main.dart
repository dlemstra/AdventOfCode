import 'dart:io';
import 'dart:math';

enum Direction {
    north,
    south,
    west,
    east
}

class Position {
    int x = 0;
    int y = 0;

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

class Elve {
    Position position;
    Position? nextPosition;

    Elve(this.position);

    void setNextPostion(Set<Position> elves, Direction direction) {
        if (!_canMove(elves)) return;

        var nextDirection = direction;
        while (nextPosition == null) {
            nextPosition = _getNextPostion(elves, nextDirection);
            nextDirection = Direction.values[(nextDirection.index + 1) % 4];
            if (nextDirection == direction) break;
        }
    }

    bool move() {
        final moved = nextPosition != null;
        if (nextPosition != null) position = nextPosition!;
        reset();
        return moved;
    }

    void reset()
        => nextPosition = null;

    bool _canMove(Set<Position> elves) {
        return
            elves.contains(new Position(position.x - 1, position.y - 1)) ||
            elves.contains(new Position(position.x, position.y - 1)) ||
            elves.contains(new Position(position.x + 1, position.y - 1)) ||
            elves.contains(new Position(position.x - 1, position.y)) ||
            elves.contains(new Position(position.x + 1, position.y)) ||
            elves.contains(new Position(position.x - 1, position.y + 1)) ||
            elves.contains(new Position(position.x, position.y + 1)) ||
            elves.contains(new Position(position.x + 1, position.y + 1));
    }

    Position? _getNextPostion(Set<Position> elves, Direction direction) {
        switch (direction) {
            case Direction.north:
                final nextPosition = new Position(position.x, position.y - 1);
                if (!elves.contains(nextPosition) &&
                    !elves.contains(new Position(position.x - 1, position.y - 1)) &&
                    !elves.contains(new Position(position.x + 1, position.y - 1))) {
                        return nextPosition;
                }
                break;
            case Direction.south:
                final nextPosition = new Position(position.x, position.y + 1);
                if (!elves.contains(nextPosition) &&
                    !elves.contains(new Position(position.x - 1, position.y + 1)) &&
                    !elves.contains(new Position(position.x + 1, position.y + 1))) {
                        return nextPosition;
                }
                break;
            case Direction.west:
                final nextPosition = new Position(position.x - 1, position.y);
                if (!elves.contains(nextPosition) &&
                    !elves.contains(new Position(position.x - 1, position.y - 1)) &&
                    !elves.contains(new Position(position.x - 1, position.y + 1))) {
                        return nextPosition;
                }
                break;
            case Direction.east:
                final nextPosition = new Position(position.x + 1, position.y);
                if (!elves.contains(nextPosition) &&
                    !elves.contains(new Position(position.x + 1, position.y - 1)) &&
                    !elves.contains(new Position(position.x + 1, position.y + 1))) {
                        return nextPosition;
                }
                break;
        }

        return null;
    }
}

int emptyTileCount(Set<Position> elves) {
    final minY = elves.map((elve) => elve.y).reduce(min);
    final minX = elves.map((elve) => elve.x).reduce(min);
    final maxY = elves.map((elve) => elve.y).reduce(max) + 1;
    final maxX = elves.map((elve) => elve.x).reduce(max) + 1;

    var count = 0;
    for (var y = minY; y < maxY; y++) {
        final row = <String>[];
        for (var x = minX; x < maxX; x++) {
            if (!elves.contains(new Position(x, y))) count++;
        }
    }

    return count;
}

solve(List<String> lines) {
    var elves = <Elve>[];

    var y = 0;
    for (var line in lines) {
        for (var x = 0; x < line.length; x++) {
            if (line[x] == '#') {
                elves.add(new Elve(new Position(x, y)));
            }
        }
        y++;
    }

    Direction direction = Direction.north;
    var positions = elves.map((elve) => elve.position).toSet();

    for (var i = 0; i < 10000; i++) {
        for (var elve in elves) {
            elve.setNextPostion(positions, direction);
        }

        final seen = Set<Position>();
        final duplicates = elves.map((elve) => elve.nextPosition ?? elve.position).where((elve) => !seen.add(elve)).toList();

        var moved = 0;
        for (var elve in elves) {
            if (duplicates.contains(elve.nextPosition)) elve.reset();
            if (elve.move()) moved++;
        }

        positions = elves.map((elve) => elve.position).toSet();
        direction = Direction.values[(direction.index + 1) % 4];

        if (i == 10) print("\r${emptyTileCount(positions)}");
        stdout.write("\r${i}");
        if (moved == 0) {
            print("\r${i + 1}");
            break;
        }
    }
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
