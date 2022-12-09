import 'dart:io';
import 'dart:math';

class Position {
  int x = 0;
  int y = 0;

  @override
  String toString() {
      return "${this.x}x${this.y}";
  }
}

double distance(Position position, int x, int y) {
  return sqrt((pow(position.x - x, 2) + pow(position.y - y, 2)));
}

bool inRange(Position head, Position tail) {
  return distance(head, tail.x, tail.y) < 1.42;
}

void part1(List<String> lines) {
  final visited = <String>{};

  var head = new Position();
  var tail = new Position();
  visited.add(tail.toString());

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

      if (!inRange(head, tail)) {
        if (distance(tail, head.x, head.y + 1) < 1.42) {
          tail.x = head.x;
          tail.y = head.y + 1;
        } else if (distance(tail, head.x, head.y - 1) < 1.42) {
          tail.x = head.x;
          tail.y = head.y - 1;
        } else if (distance(tail, head.x + 1, head.y) < 1.42) {
          tail.x = head.x + 1;
          tail.y = head.y;
        } else if (distance(tail, head.x - 1, head.y) < 1.42) {
          tail.x = head.x - 1;
          tail.y = head.y;
        }
        visited.add(tail.toString());
      }
    }
  }

  print(visited.length);
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  part1(lines);
}
