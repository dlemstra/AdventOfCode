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

    void setNextPostion(List<Position> elves, Direction direction) {
        if (!_canMove(elves)) return;

        var nextDirection = direction;
        while (nextPosition == null) {
            nextPosition = _getNextPostion(elves, nextDirection);
            nextDirection = Direction.values[(nextDirection.index + 1) % 4];
            if (nextDirection == direction) break;
        }
    }

    void move() {
        if (nextPosition != null) position = nextPosition!;
        reset();
    }

    void reset()
        => nextPosition = null;

    bool _canMove(List<Position> elves) {
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

    Position? _getNextPostion(List<Position> elves, Direction direction) {
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

int emptyTileCount(List<Position> elves) {
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
    var positions = elves.map((elve) => elve.position).toList();

    for (var i = 0; i < 10; i++) {
        for (var elve in elves) {
            elve.setNextPostion(positions, direction);
        }

        final seen = Set<Position>();
        final duplicates = elves.map((elve) => elve.nextPosition ?? elve.position).where((elve) => !seen.add(elve)).toList();

        for (var elve in elves) {
            if (duplicates.contains(elve.nextPosition)) elve.reset();
            else elve.move();
        }

        positions = elves.map((elve) => elve.position).toList();
        direction = Direction.values[(direction.index + 1) % 4];
    }

    print(emptyTileCount(positions));
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
