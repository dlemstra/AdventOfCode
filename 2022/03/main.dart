import 'dart:io';

List<List<String>> getCompartments(List<String> lines) {
  final result = <List<String>>[];

  for (final line in lines) {
    final length = line.length ~/ 2;
    result.add([line.substring(0, length), line.substring(length)]);
  }
  return result;
}

List<int> getItems(String str) {
  final result = <int>[];
  for (var item in str.runes.toSet().toList()) {
    result.add(item - (item <= 90 ? 38 : 96));
  }

  return result;
}

int getKeyWithCount(Map content, int count) {
  for (int key in content.keys) {
    if (content[key] == count) {
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
      for (final item in getItems(compartment)) {
        if (content[item] == null) {
          content[item] = 0;
        }
        content[item] += 1;
      }
    }
    sum += getKeyWithCount(content, 2);
  }

  return sum;
}

int part2(List<String> rucksacks) {
  var sum = 0;

  for (var i=0; i < rucksacks.length; i += 3) {
    final content = new Map();
    for (var k=i; k < i + 3; k++) {
      for (final item in getItems(rucksacks[k])) {
        if (content[item] == null) {
          content[item] = 0;
        }
        content[item] += 1;
      }
    }
    sum += getKeyWithCount(content, 3);
  }

  return sum;
}

void main() {
  final input = new File("input");
  final rucksacks = input.readAsLinesSync();

  print(part1(getCompartments(rucksacks)));
  print(part2(rucksacks));
}
