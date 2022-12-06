import 'dart:io';

void part1(List<String> lines) {
  for (final line in lines) {
    final chars = line.runes.toList();
    for (var i=0; i < line.length - 4; i++) {
      if (chars.sublist(i, i + 4).toSet().toList().length == 4) {
        print(i + 4);
        break;
      }
    }
  }
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  part1(lines);
}
