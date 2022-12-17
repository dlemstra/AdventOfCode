import 'dart:io';

class Rock {
    List<String> rows = [];

    Rock(List<String> rows) {
        this.rows = rows;
    }

    int get height
        => rows.length;
}

void drawMap(List<String> cave) {
    for (final row in cave.reversed) {
        print("|" + row + "|");
    }
}

void addRows(List<String> cave) {
    for (var i = 0; i < 3; i ++) {
        cave.add(".......");
    }
}

List<Rock> createRocks() {
    final rocks = <Rock>[];
    rocks.add(new Rock(["..@@@@."]));
    rocks.add(new Rock(["...@...", "..@@@..", "...@..."]));
    rocks.add(new Rock(["..@@@..", "....@..", "....@.."]));
    rocks.add(new Rock(["..@....", "..@....", "..@....", "..@...."]));
    rocks.add(new Rock(["..@@...", "..@@..."]));

    return rocks;
}

String replaceCharAt(String oldString, int index, String newChar) {
  return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
}

List<String> moveRockLeftRight(List<String> rows, bool moveRight) {
    final newRows = <String>[];

    for (final row in rows) {
        var index = moveRight ? row.lastIndexOf("@") : row.indexOf("@");
        if (index == (moveRight ? 6 : 0) || row[moveRight ? index + 1 : index - 1] == '#') {
            break;
        }

        var newRow = row;
        while (row[index] == "@") {
            newRow = replaceCharAt(newRow, index, ".");
            newRow = replaceCharAt(newRow, moveRight ? index + 1 : index - 1, "@");
            index = moveRight ? index - 1 : index + 1;
            if (moveRight && index == -1) {
                break;
            }
            if (!moveRight && index == 7) {
                break;
            }
        }
        newRows.add(newRow);
    }

    if (newRows.length != rows.length) {
        newRows.clear();
    }

    return newRows;
}

List<String> moveRockDown(List<String> rows) {
    final newRows = <String>[];

    for (var i = 0; i < rows.length - 1; i++) {
        var newRow = "";
        for (var j = 0; j < 7; j++) {
            if (rows[i + 1][j] == '@') {
                if (rows[i][j] != '.') {
                    break;
                } else {
                    newRow += "@";
                }
            } else {
                newRow += rows[i][j];
            }
        }

        if (newRow.length != 7) {
            break;
        }

        rows[i + 1] = rows[i + 1].replaceAll("@", ".");

        newRows.add(newRow);
    }

    if (newRows.length != rows.length - 1) {
        newRows.clear();
    } else {
        newRows.add(rows.last.replaceAll("@", "."));
    }

    return newRows;
}

void solve(String jetPattern) {
    final cave = <String>[];
    cave.add("-------");

    final rocks = createRocks();

    var jetIndex = 0;
    var rockIndex = 0;

    while (rockIndex < 2022) {
        addRows(cave);
        final rock = rocks[rockIndex % rocks.length];
        for (final row in rock.rows) {
            cave.add(row);
        }

        var rowIndex = cave.length;
        var done = false;
        while (!done) {
            var startIndex = rowIndex - rock.height;
            var newRows = moveRockLeftRight(cave.sublist(startIndex, startIndex + rock.height), jetPattern[jetIndex % jetPattern.length] == ">");
            for (final newRow in newRows) { cave.removeAt(--rowIndex); }
            for (final newRow in newRows) { cave.insert(rowIndex++, newRow); }

            startIndex--;
            final rows = cave.sublist(startIndex, startIndex + rock.height + 1);
            newRows = moveRockDown(rows);
            if (newRows.length == 0) {
                done = true;
                for (final row in rows) {
                    newRows.add(row.replaceAll("@", "#"));
                }
            }

            for (final newRow in newRows) { cave.removeAt(--rowIndex); }
            for (final newRow in newRows) { cave.insert(rowIndex++, newRow); }

            jetIndex++;
            rowIndex--;

            while (cave.last == ".......") {
                cave.removeLast();
            }
        }
        rockIndex++;
    }

    print (cave.length - 1);
}


void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines[0]);
}
