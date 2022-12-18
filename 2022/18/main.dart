import 'dart:io';
import 'dart:math';

class Cube {
    final int x;
    final int y;
    final int z;

    Cube(this.x, this.y, this.z);

    List<Cube> neighbours()
        => [new Cube(x - 1, y, z), new Cube(x + 1, y, z),
            new Cube(x, y - 1, z), new Cube(x, y + 1, z),
            new Cube(x, y, z - 1), new Cube(x, y, z + 1)];

    @override
    String toString()
        => "${this.x}x${this.y}x${this.z}";

    @override
    bool operator ==(covariant Cube other)
        => this.x == other.x && this.y == other.y && this.z == other.z;
}

void solve(List<String> lines) {
    var minX = 100000;
    var maxX = 0;
    var minY = 100000;
    var maxY = 0;
    var minZ = 100000;
    var maxZ = 0;

    final cubes = <Cube>[];
    for (final line in lines) {
        final info = line.split(",");
        final cube = new Cube(int.parse(info[0]), int.parse(info[1]), int.parse(info[2]));
        cubes.add(cube);

        minX = min(cube.x - 1, minX);
        maxX = max(cube.x + 1, maxX);
        minY = min(cube.y - 1, minY);
        maxY = max(cube.y + 1, maxY);
        minZ = min(cube.z - 1, minZ);
        maxZ = max(cube.z + 1, maxZ);
    }

    final neighbours = cubes.map((cube) => cube.neighbours()).expand((cube) => cube).toList();

    final part1 = new List<Cube>.from(neighbours);
    part1.retainWhere((cube) => !cubes.contains(cube));
    print(part1.length);

    final newCubes = <Cube>[];
    final stack = <Cube>[];
    stack.add(new Cube(minX, minY, minZ));
    while (stack.length > 0) {
        final cube = stack.removeLast();

        newCubes.add(cube);

        for (final neighbour in cube.neighbours()) {
            if (cubes.contains(neighbour)) {
                continue;
            }

            if (newCubes.contains(neighbour)) {
                continue;
            }

            if (neighbour.x < minX || neighbour.x > maxX ||
                neighbour.y < minY || neighbour.y > maxY ||
                neighbour.z < minZ || neighbour.z > maxZ) {
                continue;
            }

            stack.add(neighbour);
        }
    }

    final part2 = new List<Cube>.from(neighbours);
    part2.retainWhere((cube) => newCubes.contains(cube));
    print(part2.length);
}


void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
