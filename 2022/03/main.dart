import 'dart:io';

List<List<String>> getRucksacks(List<String> lines) {
  final result = <List<String>>[];

  for (final line in lines) {
    final length = line.length ~/ 2;
    result.add([line.substring(0, length), line.substring(length)]);
  }
  return result;
}

int getPrioritySum(Map content) {
  for (int key in content.keys) {
    if (content[key] == 2) {
      return key;
    }
  }

  return 0;
}

int part1(List<List<String>> rucksacks) {
  var sum = 0;

  for (final rucksack in rucksacks) {
    final content = new Map();
    for (final compartment in rucksack) {
      for (var item in compartment.runes.toSet().toList()) {
        item -= item <= 90 ? 38 : 96;
        if (content[item] == null) {
          content[item] = 0;
        }
        content[item] += 1;
      }
    }
    sum += getPrioritySum(content);
  }

  return sum;
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  final rucksacks = getRucksacks(lines);
  print(part1(rucksacks));
}
