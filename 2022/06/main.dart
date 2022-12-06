import 'dart:io';

void solve(List<String> lines, int count) {
  for (final line in lines) {
    final chars = line.runes.toList();
    for (var i=0; i < line.length - count; i++) {
      if (chars.sublist(i, i + count).toSet().toList().length == count) {
        print(i + count);
        break;
      }
    }
  }
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  solve(lines, 4);
  solve(lines, 14);
}
