internal class Day6 : Puzzle
{
    public override async Task<string> Part1(string input)
    {
        var (map, startX, startY) = LoadMap(input);
        var direction = Direction.North;

        var visited = new HashSet<string>();
        while (startX >= 0 && startX < map[0].Length && startY >= 0 && startY < map.Length)
        {
            if (map[startY][startX] == '#')
            {
                switch (direction)
                {
                    case Direction.North:
                        startY++;
                        break;
                    case Direction.East:
                        startX--;
                        break;
                    case Direction.South:
                        startY--;
                        break;
                    case Direction.West:
                        startX++;
                        break;
                }
                direction = (Direction)(((int)direction + 1) % 4);
            }

            visited.Add($"{startX},{startY}");
            await SetIntermediateResult(visited.Count);

            switch (direction)
            {
                case Direction.North:
                    startY--;
                    break;
                case Direction.East:
                    startX++;
                    break;
                case Direction.South:
                    startY++;
                    break;
                case Direction.West:
                    startX--;
                    break;
            }
        }

        return visited.Count.ToString();
    }

    public override async Task<string> Part2(string input)
    {
        var (map, startX, startY) = LoadMap(input);

        var visited = GetVisitedPositions(ref map, startX, startY, -1, -1)!;

        var total = 0;
        var positions = new HashSet<(int, int)>(10_000);
        foreach (var position in visited)
        {
            var (x, y, _) = position;
            if (!(x == startX && y == startY))
                positions.Add((x, y));
        }

        foreach (var position in positions)
        {
            var (x, y) = position;
            visited = GetVisitedPositions(ref map, startX, startY, x, y);
            if (visited == null)
            {
                total++;
                await SetIntermediateResult(total);
            }
        }

        return total.ToString();
    }

    private HashSet<(int, int, Direction)>? GetVisitedPositions(ref char[][] map, int startX, int startY, int blockX, int blockY)
    {
        var visited = new HashSet<(int, int, Direction)>(10_000);
        var guardX = startX;
        var guardY = startY;
        var direction = Direction.North;

        while (guardX >= 0 && guardX < map[0].Length && guardY >= 0 && guardY < map.Length)
        {
            if (map[guardY][guardX] == '#' || (guardX == blockX && guardY == blockY))
            {
                switch (direction)
                {
                    case Direction.North:
                        guardY++;
                        break;
                    case Direction.East:
                        guardX--;
                        break;
                    case Direction.South:
                        guardY--;
                        break;
                    case Direction.West:
                        guardX++;
                        break;
                }
                direction = (Direction)(((int)direction + 1) % 4);
            }

            if (!visited.Add((guardX, guardY, direction)))
                return null;

            switch (direction)
            {
                case Direction.North:
                    guardY--;
                    break;
                case Direction.East:
                    guardX++;
                    break;
                case Direction.South:
                    guardY++;
                    break;
                case Direction.West:
                    guardX--;
                    break;
            }
        }

        return visited;
    }

    private (char[][], int startX, int startY) LoadMap(string input)
    {
        var lines = input.Split('\n');
        var grid = new char[lines.Length][];

        var y = 0;
        var startX = -1;
        var startY = -1;
        foreach (var line in lines)
        {
            grid[y] = line.Trim().ToCharArray();
            if (startY == -1)
            {
                startX = Array.IndexOf(grid[y], '^');
                if (startX != -1)
                    startY = y;
            }
            y++;
        }

        return (grid, startX, startY);
    }

    enum Direction
    {
        North,
        East,
        South,
        West
    }
}
