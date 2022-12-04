import 'dart:io';
import 'dart:math';

void solve(List<String> jobs) {
  var part1 = 0;
  var part2 = 0;

  for (final job in jobs) {
    final info = job.split(",");
    final a = info[0].split("-").map((e) => int.parse(e)).toList();
    final b = info[1].split("-").map((e) => int.parse(e)).toList();
    if ((a[0] >= b[0] && a[1] <= b[1]) || (b[0] >= a[0] && b[1] <= a[1])) {
      part1++;
    }
    final s = max(a[0], b[0]);
    final e = min(a[1], b[1]);
    if (s <= e) {
      part2++;
    }
  }

  print(part1);
  print(part2);
}

void main() {
  final input = new File("input");
  final jobs = input.readAsLinesSync();

  solve(jobs);
}
