import 'dart:io';
import 'dart:math';

class Position {
    int x = 0;
    int y = 0;

    Position(int x, int y) {
        this.x = x;
        this.y = y;
    }

    int distance(Position other)
        => (this.x - other.x).abs() + (this.y - other.y).abs();

    @override
    String toString()
        => "${this.x}x${this.y}";
}

int getTuningFrequency(Map sensors, int max) {
    final sortedSensors = sensors.entries.toList();
    sortedSensors.sort((a, b) => b.value.compareTo(a.value));
    final sensorKeys = sortedSensors.map((e) => e.key).toList();

    for (var y = 0; y < max; y++) {
        for (var x = 0; x < max; x++) {
            var found = false;
            for (final sensor in sensorKeys) {
                final distance = sensor.distance(new Position(x, y));
                final beaconDistance = sensors[sensor];
                if (distance <= beaconDistance) {
                    found = true;
                    x += (beaconDistance - distance) as int;
                    break;
                }
            }

            if (found == false) {
                return (x * 4000000) + y;
            }
        }
    }

    return 0;
}

void solve(List<String> lines, int y) {
    final sensors = new Map();
    final beaconsOnLine = new Set<String>();

    var minX = 0;
    var maxX = 0;
    for (final line in lines) {
        final info = line.split(" ");
        final sensor = new Position(int.parse(info[2].split(",")[0].split("=")[1]), int.parse(info[3].split(":")[0].split("=")[1]));
        final beacon = new Position(int.parse(info[8].split(",")[0].split("=")[1]), int.parse(info[9].split("=")[1]));
        sensors[sensor] = sensor.distance(beacon);

        minX = min(min(beacon.x, sensor.x), minX);
        maxX = max(max(beacon.x, sensor.x), maxX);

        if (beacon.y == y) {
            beaconsOnLine.add(beacon.toString());
        }
    }

    var count = -beaconsOnLine.length;

    minX -= minX.abs();
    maxX += maxX;
    var postion = Position(minX, y);
    while (postion.x <  maxX) {
        for (final sensor in sensors.keys) {
            final distance = sensor.distance(postion);
            if (distance <= sensors[sensor]) {
                count++;
                break;
            }
        }
        postion.x++;
    }

    print(count);
    print(getTuningFrequency(sensors, y * 2));
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines, 2000000);
}
