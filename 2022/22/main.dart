import 'dart:io';

enum Direction {
    right,
    down,
    left,
    up
}

int getNextY(int y, Direction direction) {
    switch (direction) {
        case Direction.up: return y - 1;
        case Direction.down: return y + 1;
        default: return y;
    }
}

int getNextX(int x, Direction direction) {
    switch (direction) {
        case Direction.left: return x - 1;
        case Direction.right: return x + 1;
        default: return x;
    }
}

Direction turnAround(Direction direction) {
    switch (direction) {
        case Direction.up: return Direction.down;
        case Direction.down: return Direction.up;
        case Direction.left: return Direction.right;
        case Direction.right: return Direction.left;
    }
}

solve(List<String> lines) {
    var walls = new Set<String>();
    var tiles = new Set<String>();

    var y = 0;
    var xPos = 0;
    var yPos = lines.length * 100;
    for (final line in lines) {
        for (var x = 0; x < line.length; x++) {
            if (line[x] == '#') walls.add("${x}x${y}");
            else if (line[x] == '.') {
                tiles.add("${x}x${y}");
                if (y < yPos) {
                    xPos = x;
                    yPos = y;
                }
            }
        }
        y++;
        if (line == "") break;
    }

    final route = lines[y].split("R").join(" R ").split("L").join(" L ").split(" ");

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
                    var x = getNextX(xPos, direction);
                    var y = getNextY(yPos, direction);
                    var pos = "${x}x${y}";
                    if (tiles.contains(pos)) {
                        xPos = x;
                        yPos = y;
                    } else if (walls.contains(pos)) {
                        break;
                    } else {
                        direction = turnAround(direction);
                        x = getNextX(xPos, direction);
                        y = getNextY(yPos, direction);
                        pos = "${x}x${y}";
                        while ((walls.contains(pos) || tiles.contains(pos)) && x >= 0 && y >= 0) {
                            x = getNextX(x, direction);
                            y = getNextY(y, direction);
                            pos = "${x}x${y}";
                        }
                        direction = turnAround(direction);
                        x = getNextX(x, direction);
                        y = getNextY(y, direction);
                        if (walls.contains("${x}x${y}")) {
                            break;
                        }
                        xPos = x;
                        yPos = y;
                    }
                }
                break;
        }
    }

    print(1000 * (yPos + 1) + 4 * (xPos + 1) + direction.index);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
