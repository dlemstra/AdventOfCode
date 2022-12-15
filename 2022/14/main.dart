import 'dart:io';
import 'dart:math';

Set<String> getSand(Set<String> rocks, int maxY) {
    final sand = new Set<String>();

    var y = 0;
    var x = 500;
    while (y < maxY && !sand.contains("500x0")) {
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

    return sand;
}

void solve(List<String> lines) {
    final rocks = new Set<String>();

    var maxY = 0;
    var minX = 0x7fffffff;
    var maxX = 0;
    for (final line in lines) {
        final info = line.split(" -> ").map((x) => x.split(",")).toList();
        for (var i = 0; i < info.length - 1; i++) {
            final x1 = int.parse(info[i][0]);
            final y1 = int.parse(info[i][1]);
            final x2 = int.parse(info[i + 1][0]);
            final y2 = int.parse(info[i + 1][1]);

            final endY = max(y1, y2);
            maxY = max(maxY, endY);
            for (var y = min(y1, y2); y <= endY; y++) {
                final startX = min(x1, x2);
                final endX = max(x1, x2);
                minX = min(startX, minX);
                maxX = max(startX, maxX);
                for (var x = startX; x <= endX; x++) {
                    rocks.add("${x}x${y}");
                }
            }
        }
    }

    print(getSand(rocks, maxY).length);

    maxY += 2;
    for (var x = minX - 1000; x < maxX + 1000; x++) {
        rocks.add("${x}x${maxY}");
    }

    print(getSand(rocks, maxY).length);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
