import 'dart:io';

class Play {
   String theirs = "A";
   String mine = "X";

   Play.create(String theirs, String mine) {
    this.theirs = theirs;
    this.mine = mine;
   }
}

List<Play> getGuide(List<String> lines) {
  final result = <Play>[];

  for (final line in lines) {
     final info = line.split(" ");
     result.add(new Play.create(info[0], info[1]));
  }
  return result;
}

int part1(List<Play> guide) {
  var score = 0;
  for (final play in guide) {
    switch(play.mine) {
      case "X": {
        score += 1;
        if (play.theirs == "A") {
          score += 3;
        } else if (play.theirs == "C") {
          score += 6;
        }
      }
      break;
      case "Y": {
        score += 2;
        if (play.theirs == "B") {
          score += 3;
        } else if (play.theirs == "A") {
          score += 6;
        }
      }
      break;
      case "Z": {
        score += 3;
        if (play.theirs == "C") {
          score += 3;
        } else if (play.theirs == "B") {
          score += 6;
        }
      }
      break;
    }
  }
  return score;
}

int part2(List<Play> guide) {
  var score = 0;
  for (final play in guide) {
    switch(play.theirs) {
      case "A": {
        switch(play.mine) {
          case "X": {
              score += 3;
          }
          break;
          case "Y": {
              score += 1 + 3;
          }
          break;
          case "Z": {
              score += 2 + 6;
          }
          break;
        }
      }
      break;
      case "B": {
        switch(play.mine) {
          case "X": {
              score += 1;
          }
          break;
          case "Y": {
              score += 2 + 3;
          }
          break;
          case "Z": {
              score += 3 + 6;
          }
          break;
        }
      }
      break;
      case "C": {
        switch(play.mine) {
          case "X": {
              score += 2;
          }
          break;
          case "Y": {
              score += 3 + 3;
          }
          break;
          case "Z": {
              score += 1 + 6;
          }
          break;
        }
      }
      break;
    }
  }
  return score;
}

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  final guide = getGuide(lines);
  print(part1(guide));
  print(part2(guide));
}
