import 'dart:io';
import 'dart:math';

class Cube {
    int x = 0;
    int y = 0;
    int z = 0;

    Cube(int x, int y, int z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    bool touches(Cube other) {
        final distance = sqrt(pow(this.x - other.x, 2) + pow(this.y - other.y, 2) + pow(this.z - other.z, 2));
        return distance == 1.0;
    }

    @override
    String toString()
        => "${this.x}x${this.y}x${this.z}";
}

void solve(List<String> lines) {
    final cubes = <Cube>[];

    for (final line in lines) {
        final info = line.split(",");
        final cube = new Cube(int.parse(info[0]), int.parse(info[1]), int.parse(info[2]));
        cubes.add(cube);
    }

    final touchingCubes = new Set<String>();
    for (var i = 0; i < cubes.length; i++) {
        for (var j = 0; j < cubes.length; j++) {
            if (i == j) {
                continue;
            }

            if (cubes[i].touches(cubes[j])) {
                touchingCubes.add("${cubes[i]}-${cubes[j]}");
                touchingCubes.add("${cubes[j]}-${cubes[i]}");
            }
        }
    }

    final part1 = cubes.length * 6 - touchingCubes.length;
    print(part1);
}


void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
