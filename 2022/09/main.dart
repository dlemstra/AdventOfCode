import 'dart:io';
import 'dart:math';

class Position {
  int x = 0;
  int y = 0;

  Position(int x, int y) {
    this.x = x;
    this.y = y;
  }

  @override
  String toString() {
    return "${this.x}x${this.y}";
  }
}

int chebyshevDistance(Position position, int x, int y) {
  return max((x - position.x).abs(), (y - position.y).abs());
}

int distance(Position head, Position tail) {
  return chebyshevDistance(head, tail.x, tail.y);
}

Position? getNewTailPosition(Position head, Position tail) {
  if (chebyshevDistance(tail, head.x, head.y + 1) == 1) {
    return new Position(head.x, head.y + 1);
  } else if (chebyshevDistance(tail, head.x, head.y - 1) == 1) {
    return new Position(head.x, head.y - 1);
  } else if (chebyshevDistance(tail, head.x + 1, head.y) == 1) {
    return new Position(head.x + 1, head.y);
  } else if (chebyshevDistance(tail, head.x - 1, head.y) == 1) {
    return new Position(head.x - 1, head.y);
  }

  return null;
}

void solve(List<String> lines) {
  final head = new Position(0, 0);
  var tail = new Position(0, 0);

  final rope = <Position>[];
  rope.add(head);
  for (var i = 0; i < 9; i++) {
    rope.add(new Position(0, 0));
  }

  final part1 = <String>{};
  final part2 = <String>{};
  part1.add(head.toString());
  part2.add(head.toString());

  for (final line in lines) {
    final info = line.split(" ");
    for (var i=0; i < int.parse(info[1]); i++) {
      switch(info[0]) {
        case "U":
          head.y--;
          break;
        case "D":
          head.y++;
          break;
        case "L":
          head.x--;
          break;
        case "R":
          head.x++;
          break;
      }

      if (distance(head, tail) > 1) {
        tail = getNewTailPosition(head, tail)!;
        part1.add(tail.toString());
      }

      var prev = new Position(rope[0].x, rope[0].y);
      var j = 1;
      while (j < rope.length) {
        if (distance(rope[j], rope[j - 1]) <= 1) {
          break;
        }

        var newPos = getNewTailPosition(rope[j - 1], rope[j]);
        if (newPos == null) {
          newPos = prev;
        }

        prev = new Position(rope[j].x, rope[j].y);
        rope[j++] = newPos;
      }
      if (j == rope.length) {
        part2.add(rope[9].toString());
      }
    }
  }

  print(part1.length);
  print(part2.length);
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  solve(lines);
}
