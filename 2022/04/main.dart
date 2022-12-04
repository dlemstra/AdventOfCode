import 'dart:io';

int part1(List<String> jobs) {
  var count = 0;

  for (final job in jobs) {
    final info = job.split(",");
    final a = info[0].split("-").map((e) => int.parse(e)).toList();
    final b = info[1].split("-").map((e) => int.parse(e)).toList();
    if ((a[0] >= b[0] && a[1] <= b[1]) || (b[0] >= a[0] && b[1] <= a[1])) {
      count += 1;
    }
  }

  return count;
}

void main() {
  final input = new File("input");
  final jobs = input.readAsLinesSync();

  print(part1(jobs));
}
