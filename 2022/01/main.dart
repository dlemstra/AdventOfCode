import 'dart:io';

List<int> getTotals(List<String> lines) {
  final result = <int>[];

  var total = 0;
  for (final line in lines) {
    if (line == '') {
      result.add(total);
      total = 0;
    } else {
      total += int.parse(line);
    }
  }

  if (total != 0) {
      result.add(total);
  }

  result.sort((b, a) => a.compareTo(b));
  return result;
}

int part1(List<int> totals) {
  return totals[0];
}

int part2(List<int> totals) {
  return totals.take(3).fold(0, (previous, current) => previous + current);
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  final totals = getTotals(lines);
  print(part1(totals));
  print(part2(totals));
}
