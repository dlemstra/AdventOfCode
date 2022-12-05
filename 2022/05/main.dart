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

void solve(List<String> lines) {
  final stacks1 = createStacks(lines);
  final stacks2 = createStacks(lines);

  var start = 0;
  while (lines[start++] != '') { }

  for (var i=start; i < lines.length; i++) {
    final info = lines[i].split(' ');
    final count = int.parse(info[1]);
    final source = int.parse(info[3]) - 1;
    final target = int.parse(info[5]) - 1;
    for (var j=0; j < count; j++) {
      final value = stacks1[source].removeLast();
      stacks1[target].add(value);
    }
    final items = <String>[];
    for (var j=0; j < count; j++) {
      items.add(stacks2[source].removeLast());
    }
    stacks2[target].addAll(items.reversed);
  }

  var part1 = "";
  var part2 = "";
  for (var i=0; i < stacks1.length; i++) {
    part1 += stacks1[i].removeLast();
    part2 += stacks2[i].removeLast();
  }

  print(part1);
  print(part2);
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  solve(lines);
}
