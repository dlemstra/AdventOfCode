import 'dart:io';

enum Direction {
  up,
  down,
  left,
  right
}

bool isVisible(Map map, int size, int x, int y, Direction direction) {
  final value = map["${x}x${y}"];
  switch (direction) {
    case Direction.up:
      while (y > 0) {
        if (value <= map["${x}x${--y}"]) {
          return false;
        }
      }
      break;
    case Direction.down:
      while (y < size - 1) {
        if (value <= map["${x}x${++y}"]) {
          return false;
        }
      }
      break;
    case Direction.left:
      while (x > 0) {
        if (value <= map["${--x}x${y}"]) {
          return false;
        }
      }
      break;
    case Direction.right:
      while (x < size - 1) {
        if (value <= map["${++x}x${y}"]) {
          return false;
        }
      }
      break;
  }
  return true;
}


void part1(List<String> lines) {
  final map = new Map();

  var y = 0;
  for (final line in lines) {
    var x = 0;
    for (final char in line.runes) {
      map["${x}x${y}"] = (char - 48);
      x++;
    }
    y++;
  }

  final size = y;
  var visible = (size * 4) - 4;

  for (var y = 1; y < size - 1; y++) {
    for (var x = 1; x < size - 1; x++) {
      if (isVisible(map, size, x, y, Direction.up) ||
          isVisible(map, size, x, y, Direction.down) ||
          isVisible(map, size, x, y, Direction.left) ||
          isVisible(map, size, x, y, Direction.right)) {
        visible++;
      }
    }
  }

  print(visible);
}

void main() {
  final input = new File("testinput");
  final lines = input.readAsLinesSync();

  part1(lines);
}
