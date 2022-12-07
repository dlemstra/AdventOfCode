import 'dart:io';
import 'dart:math';

void part1(List<String> lines) {
  final totals = new Map();
  final path = <String>[];

  for (final line in lines) {
    if (line.startsWith("\$ cd ")) {
      final dir = line.split(" ")[2];
      if (dir == "..") {
        path.removeLast();
      } else {
        path.add(dir);
      }
    } else if (!line.startsWith("\$") && !line.startsWith("dir")) {
      for (var i=0; i < path.length; i ++) {
        final dir = path.sublist(0, i + 1).join("/");
        if (!totals.containsKey(dir)) {
          totals[dir] = 0;
        }
        final size = int.parse(line.split(" ")[0]);
        totals[dir] += size;
      }
    }
  }

  final part1 = totals.values.fold(0, (prev, element) => prev + (element <= 100000 ? element as int : 0));
  print(part1);

  final used = totals["/"];
  final unused = 70000000 - used;
  var part2 = used;
  for (final value in totals.values) {
    if (unused + value >= 30000000) {
      part2 = min<int>(part2, value);
    }
  }
  print(part2);
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  part1(lines);
}
