import 'dart:io';
import 'dart:math';

void solve(List<String> lines) {
    final rocks = new Set<String>();

    var maxY = 0;
    for (final line in lines) {
        final info = line.split(" -> ").map((x) => x.split(",")).toList();
        for (var i = 0; i < info.length - 1; i++) {
            final x1 = int.parse(info[i][0]);
            final y1 = int.parse(info[i][1]);
            final x2 = int.parse(info[i + 1][0]);
            final y2 = int.parse(info[i + 1][1]);
            for (var y = min(y1, y2); y <= max(y1, y2); y++) {
                maxY = max(y, maxY);
                for (var x = min(x1, x2); x <= max(x1, x2); x++) {
                    rocks.add("${x}x${y}");
                }
            }
        }
    }

    final sand = new Set<String>();

    var y = 0;
    var x = 500;
    while (y < maxY) {
         if (rocks.contains("${x}x${y + 1}") || sand.contains("${x}x${y + 1}")) {
            if (sand.contains("${x - 1}x${y + 1}") || rocks.contains("${x - 1}x${y + 1}")) {
                if (sand.contains("${x + 1}x${y + 1}") || rocks.contains("${x + 1}x${y + 1}")) {
                    sand.add("${x}x${y}");
                    y = 0;
                    x = 500;
                } else {
                    x = x + 1;
                    y = y + 1;
                }
            } else {
                x = x - 1;
                y = y + 1;
            }
        } else {
            y++;
        }
    }

    print(sand.length);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
