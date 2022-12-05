import 'dart:io';

List<List<String>> createStacks(List<String> lines) {
  final stacks = <List<String>>[];

  for (final line in lines) {
    for (var i=0 ; i < line.length; i += 4) {
      final char = line[i + 1];
      if (char == "1") {
        return stacks;
      }
      if (char != ' ') {
          final index = i ~/ 4;
          while (stacks.length < index + 1) {
            stacks.add(<String>[]);
          }
          stacks[index].insert(0, char);
      }
    }
  }
  return stacks;
}

String part1(List<String> lines) {
  final stacks = createStacks(lines);

  var start = 0;
  while (lines[start++] != '') { }

  for (var i=start; i < lines.length; i++) {
    final info = lines[i].split(' ');
    final count = int.parse(info[1]);
    final source = int.parse(info[3]) - 1;
    final target = int.parse(info[5]) - 1;
    for (var j=0; j < count; j++) {
      final value = stacks[source].removeLast();
      stacks[target].add(value);
    }
  }

  var result = "";
  for (var i=0; i < stacks.length; i++) {
    result += stacks[i].removeLast();
  }

  return result;
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  print(part1(lines));
}
