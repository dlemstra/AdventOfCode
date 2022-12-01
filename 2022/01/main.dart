import 'dart:io';
import 'dart:math';

void part1(List<String> lines) {
  var highest = 0;
  var total = 0;
  for (var line in lines) {
    if (line == '') {
      highest = max(highest, total);
      total = 0;
    } else {
      total += int.parse(line);
    }
  }
  print(highest);
}

void main() {
  var input = new File("input");
  var lines = input.readAsLinesSync();

  part1(lines);
}