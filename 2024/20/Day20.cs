internal sealed class Day20 : Puzzle
{
    public override async Task<string> Part1(string input)
    {
        var (grid, startX, startY, endX, endY) = LoadGrid(input);
        var (count, visited) = StepCount(grid, startX, startY, endX, endY);

        var total = await GetTotal(grid, visited, 2);
        return total.ToString();
    }

    public override async Task<string> Part2(string input)
    {
        var (grid, startX, startY, endX, endY) = LoadGrid(input);
        var (count, visited) = StepCount(grid, startX, startY, endX, endY);

        var total = await GetTotal(grid, visited, 20);
        return total.ToString();
    }

    private async Task<int> GetTotal(char[][] grid, IReadOnlyDictionary<(int, int), int> visited, int maxSteps)
    {
        var total = 0;
        foreach (var ((x, y), startCount) in visited)
        {
            foreach (var (dx, dy) in FindSteps(grid, x, y, maxSteps))
            {
                if (dx == 0 && dy == 0)
                    continue;

                var xx = x + dx;
                var yy = y + dy;

                if (!visited.TryGetValue((xx, yy), out var steps))
                    continue;

                var skipped = steps - (startCount + (Math.Abs(dx) + Math.Abs(dy)));
                if (skipped >= 100)
                    total++;
            }

            await SetIntermediateResult(total);
        }

        return total;
    }

    private static IEnumerable<(int, int)> FindSteps(char[][] grid, int startX, int startY, int steps)
    {
        for (var dy = -steps; dy <= steps; dy++)
        {
            for (var dx = -(steps - Math.Abs(dy)); dx <= (steps - Math.Abs(dy)); dx++)
                yield return (dx, dy);
        }
    }

    private static (int, IReadOnlyDictionary<(int, int), int>) StepCount(char[][] grid, int startX, int startY, int endX, int endY)
    {
        var visited = new Dictionary<(int, int), int>();

        var positions = new Queue<(int, int, int)>();
        positions.Enqueue((startX, startY, 0));

        while (positions.Count > 0)
        {
            var (x, y, steps) = positions.Dequeue();

            visited[(x, y)] = steps;

            if (grid[y][x] == 'E')
                return (steps, visited);

            foreach (var (dx, dy) in new[] { (1, 0), (-1, 0), (0, 1), (0, -1) })
            {
                var newX = x + dx;
                var newY = y + dy;

                if (grid[newY][newX] == '#')
                    continue;

                if (visited.ContainsKey((newX, newY)))
                    continue;

                positions.Enqueue((newX, newY, steps + 1));
            }
        }

        return (-1, visited);
    }

    private static (char[][], int, int, int, int) LoadGrid(string input)
    {
        var lines = input.Split('\n');
        var grid = new char[lines.Length][];
        var startX = 0;
        var startY = 0;
        var endX = 0;
        var endY = 0;

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
            else
            {
                pos = Array.IndexOf(grid[y], 'E');
                if (pos != -1)
                {
                    endX = pos;
                    endY = y;
                }
            }
            y++;
        }

        return (grid, startX, startY, endX, endY);
    }
}
