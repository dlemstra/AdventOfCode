import 'dart:io';

void solve(List<String> lines) {
  final cycles = [20, 60, 100, 140, 180, 220];
  var cycle = 0;
  var x = 1;

  var part1 = 0;
  for (final line in lines) {
    final count = line == "noop" ? 1 : 2;
    final info = line.split(" ");
    final addition = info.length == 2 ? int.parse(info[1]) : 0;
    for (var i = 0; i < count; i++) {
      cycle++;
      if (cycles.contains(cycle)) {
        part1 += cycle * x;
      }
    }
    x += addition;
  }

  print(part1);
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  solve(lines);
}
