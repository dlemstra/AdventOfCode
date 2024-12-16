internal sealed class Day16 : IPuzzle
{
    public string Part1(string input)
    {
        var (grid, startX, startY) = LoadGrid(input);

        (int, int, Direction)[] directions = [
            (0, -1, Direction.North),
            (1, 0, Direction.East),
            (0, 1, Direction.South),
            ( -1, 0, Direction.West),
        ];

        var paths = new LinkedList<(int, int, Direction, int)>();
        paths.AddLast((startX, startY, Direction.East, 0));

        var visited = new Dictionary<(int, int, Direction), int>();
        visited.Add((startX, startY, Direction.East), 0);

        var bestScore = int.MaxValue;
        while (paths.Count > 0)
        {
            var (x, y, direction, score) = paths.First();
            paths.RemoveFirst();

            if (visited.TryGetValue((x, y, direction), out var visitedScore))
            {
                if (visitedScore < score)
                    continue;
            }

            if (grid[y][x] == 'E')
            {
                if (score < bestScore)
                    bestScore = score;
                continue;
            }

            visited[(x, y, direction)] = score;

            foreach (var (dx, dy, newDirection) in directions)
            {
                if (grid[y + dy][x + dx] != '#')
                {
                    var price = 1 + (direction == newDirection ? 0 : 1000);
                    paths.AddLast((x + dx, y + dy, newDirection, score + price));
                }
            }
        }

        return bestScore.ToString();
    }

    public string Part2(string input)
    {
        var (grid, startX, startY) = LoadGrid(input);

        (int, int, Direction)[] directions = [
            (0, -1, Direction.North),
            (1, 0, Direction.East),
            (0, 1, Direction.South),
            ( -1, 0, Direction.West),
        ];

        var paths = new LinkedList<(int, int, Direction, int, HashSet<(int, int)>)>();
        paths.AddLast((startX, startY, Direction.East, 0, []));

        var visited = new Dictionary<(int, int, Direction), int>();
        visited.Add((startX, startY, Direction.East), 0);

        var bestScore = int.MaxValue;
        var bestPositions = new HashSet<(int, int)>();

        while (paths.Count > 0)
        {
            var (x, y, direction, score, positions) = paths.First();
            paths.RemoveFirst();

            if (visited.TryGetValue((x, y, direction), out var visitedScore))
            {
                if (visitedScore < score)
                    continue;
            }

            positions.Add((x, y));

            if (grid[y][x] == 'E')
            {
                if (score < bestScore)
                {
                    bestScore = score;
                    bestPositions = positions;
                }
                else if (score == bestScore)
                {
                    foreach (var pos in positions)
                    {
                        bestPositions.Add(pos);
                    }
                }

                continue;
            }

            visited[(x, y, direction)] = score;

            foreach (var (dx, dy, newDirection) in directions)
            {
                if (grid[y + dy][x + dx] != '#')
                {
                    var price = 1 + (direction == newDirection ? 0 : 1000);
                    paths.AddLast((x + dx, y + dy, newDirection, score + price, new HashSet<(int, int)>(positions)));
                }
            }
        }

        return bestPositions.Count.ToString();
    }

    private static (char[][], int, int) LoadGrid(string input)
    {
        var lines = input.Split('\n');
        var grid = new char[lines.Length][];
        var startX = 0;
        var startY = 0;

        var y = 0;
        foreach (var line in lines)
        {
            grid[y] = line.Trim().ToCharArray();
            var pos = Array.IndexOf(grid[y], 'S');
            if (pos != -1)
            {
                startX = pos;
                startY = y;
            }
            y++;
        }

        return (grid, startX, startY);
    }

    private enum Direction
    {
        North,
        East,
        South,
        West,
    }
}
