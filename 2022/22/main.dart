import 'dart:io';

enum Direction {
    right,
    down,
    left,
    up
}

class Position {
    int x = 0;
    int y = 0;

    Position(this.x, this.y);

    Position.from(Position other) {
        this.x = other.x;
        this.y = other.y;
    }

    @override
    String toString()
        => "${x}x${y}";
}

Position nextPosition(Position position, Direction direction) {
    switch (direction) {
        case Direction.up: return new Position(position.x, position.y - 1);
        case Direction.down: return new Position(position.x, position.y + 1);
        case Direction.left: return new Position(position.x - 1, position.y);
        case Direction.right: return new Position(position.x + 1, position.y);
    }
}

List nextCubePosition(Position position, Direction direction, int size) {
     //  12
     //  3
     // 45
     // 6

    switch(direction) {
        case Direction.up:
            if (position.x < size) return [new Position(size, size + position.x), Direction.right]; // 4U => 3R
            if (position.x < size * 2) return [new Position(0, (size * 2) + position.x), Direction.right]; // 1U => 6L
            if (position.x < size * 3) return [new Position(position.x - (size * 2), (size * 4) - 1), Direction.up]; // 2U => 6D
            break;
        case Direction.down:
            if (position.x < size) return [new Position((size * 2) + position.x, 0), Direction.down]; // 6D => 2U
            if (position.x < size * 2) return [new Position(size - 1, (size * 2) + position.x), Direction.left]; // 5D => 6L
            if (position.x < size * 3) return [new Position((size * 2) - 1, position.x - size), Direction.left];  // 2D => 3R
            break;
        case Direction.left:
            if (position.y < size) return [new Position(0, (size * 3) - 1 - position.y), Direction.right]; // 1L => 4L
            if (position.y < size * 2) return [new Position(position.y - size, size * 2), Direction.down]; // 3L => 4U
            if (position.y < size * 3) return [new Position(size, (size * 3) - 1 - position.y), Direction.right]; // 4L => 1L
            if (position.y < size * 4) return [new Position(position.y - (size * 2), 0), Direction.down]; // 6L => 1U
            break;
        case Direction.right:
            if (position.y < size) return [new Position((size * 2) - 1, (size * 3) - 1 - position.y), Direction.left]; // 2R => 5R
            if (position.y < size * 2) return [new Position(size + position.y, size - 1), Direction.up]; // 3R => 2D
            if (position.y < size * 3) return [new Position((size * 3) - 1, (size * 3) - 1 - position.y), Direction.left]; // 5R => 2R
            if (position.y < size * 4) return [new Position(position.y - (size * 2), (size * 3) - 1), Direction.up]; // 6R => 5D
            break;
    }

    throw new Exception();
}

Direction turnAround(Direction direction) {
    switch (direction) {
        case Direction.up: return Direction.down;
        case Direction.down: return Direction.up;
        case Direction.left: return Direction.right;
        case Direction.right: return Direction.left;
    }
}

Position wrapAround(Set<String> tiles, Set<String> walls, Position position, Direction direction) {
    direction = turnAround(direction);
    var pos = Position.from(position);
    while (walls.contains(pos.toString()) || tiles.contains(pos.toString())) {
        pos = nextPosition(pos, direction);
    }
    direction = turnAround(direction);
    pos = nextPosition(pos, direction);
    return pos;
}

void move(Set<String> tiles, Set<String> walls, List<String> route, Position position, int cubeSize) {
    var direction = Direction.right;
    for (var i = 0; i < route.length; i ++) {
        switch (route[i]) {
            case "R":
                direction = Direction.values[(direction.index + 1) % 4];
                break;
            case "L":
                direction = Direction.values[(direction.index - 1) % 4];
                break;
            default:
                var count = int.parse(route[i]);
                while (count-- != 0) {
                    var pos = nextPosition(position, direction);
                    if (tiles.contains(pos.toString())) {
                        position = pos;
                    } else if (walls.contains(pos.toString())) {
                        break;
                    } else {
                        var newDirection = direction;
                        if (cubeSize > 0) {
                            final info = nextCubePosition(position, direction, cubeSize);
                            pos = info[0];
                            newDirection = info[1];
                        } else {
                            pos = wrapAround(tiles, walls, position, direction);
                        }
                        if (walls.contains(pos.toString())) {
                            break;
                        }

                        position = pos;
                        direction = newDirection;
                    }
                }
                break;
        }
    }

    print(1000 * (position.y + 1) + 4 * (position.x + 1) + direction.index);
}

solve(List<String> lines) {
    final walls = new Set<String>();
    final tiles = new Set<String>();

    final pos = new Position(0, 100);
    var y = 0;
    for (final line in lines) {
        for (var x = 0; x < line.length; x++) {
            if (line[x] == '#') walls.add("${x}x${y}");
            else if (line[x] == '.') {
                tiles.add("${x}x${y}");
                if (y < pos.y) {
                    pos.x = x;
                    pos.y = y;
                }
            }
        }
        y++;
        if (line == "") break;
    }

    final route = lines[y].split("R").join(" R ").split("L").join(" L ").split(" ");
    final cubeSize = ((lines.length -2 ) / 4).floor();

    move(tiles, walls, route, pos, 0);
    move(tiles, walls, route, pos, cubeSize);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
