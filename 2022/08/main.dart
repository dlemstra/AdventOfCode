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

int visibleCount(Map map, int max, int x, int y, Direction direction) {
  final value = map["${x}x${y}"];
  var count = 0;
  switch (direction) {
    case Direction.up:
      while (y > 0) {
        count++;
        if (value <= map["${x}x${--y}"]) {
          return count;
        }
      }
      break;
    case Direction.down:
      while (y < max) {
        count++;
        if (value <= map["${x}x${++y}"]) {
          return count;
        }
      }
      break;
    case Direction.left:
      while (x > 0) {
        count++;
        if (value <= map["${--x}x${y}"]) {
          return count;
        }
      }
      break;
    case Direction.right:
      while (x < max) {
        count++;
        if (value <= map["${++x}x${y}"]) {
          return count;
        }
      }
      break;
  }
  return count;
}

void solve(List<String> lines) {
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
  final max = size - 1;

  var part1 = (size * 4) - 4;
  for (var y = 1; y < size - 1; y++) {
    for (var x = 1; x < size - 1; x++) {
      if (isVisible(map, size, x, y, Direction.up) ||
          isVisible(map, size, x, y, Direction.down) ||
          isVisible(map, size, x, y, Direction.left) ||
          isVisible(map, size, x, y, Direction.right)) {
        part1++;
      }
    }
  }

  print(part1);

  var part2 = 0;
  for (var y = 1; y < size - 1; y++) {
    for (var x = 1; x < size - 1; x++) {
      final score = visibleCount(map, max, x, y, Direction.up) *
                    visibleCount(map, max, x, y, Direction.down) *
                    visibleCount(map, max, x, y, Direction.left) *
                    visibleCount(map, max, x, y, Direction.right);
      if (score > part2) {
        part2 = score;
      }
    }
  }

  print(part2);
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  solve(lines);
}
