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
  for (var play in guide) {
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

void main() {
  final input = new File("input");
  final lines = input.readAsLinesSync();

  final guide = getGuide(lines);
  print(part1(guide));
}
