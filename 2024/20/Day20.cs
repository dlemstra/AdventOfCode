internal sealed class Day20 : Puzzle
{
    public override async Task<string> Part1(string input)
    {
        var (grid, startX, startY, endX, endY) = LoadGrid(input);
        var count = StepCount(grid, startX, startY, endX, endY, int.MaxValue);
        Console.WriteLine(count);

        var total = 0;
        for (var y = 1; y < grid.Length - 1; y++)
        {
            for (var x = 1; x < grid[y].Length - 1; x++)
            {
                if (grid[y][x] != '#')
                    continue;

                var copy = CopyGrid(grid);
                copy[y][x] = '.';
                var newCount = StepCount(copy, startX, startY, endX, endY, count - 100);

                if (newCount > 0 && newCount < count)
                {
                    total++;
                    await SetIntermediateResult(total);
                }
            }
        }

        return total.ToString();
    }

    public override Task<string> Part2(string input)
    {
        return Task.FromResult("Not implemented");
    }

    private char[][] CopyGrid(char[][] input)
    {
        var result = new char[input.Length][];
        for (var y = 0; y < input.Length; y++)
        {
            result[y] = new char[input[y].Length];
            for (var x = 0; x < input[y].Length; x++)
            {
                result[y][x] = input[y][x];
            }
        }
        return result;
    }

    private int StepCount(char[][] grid, int startX, int startY, int endX, int endY, int max)
    {
        var visited = new HashSet<(int, int)>();

        var positions = new LinkedList<(int, int, int)>();
        positions.AddLast((startX, startY, 0));

        while (positions.Count > 0)
        {
            var (x, y, steps) = positions.First();
            positions.RemoveFirst();

            if (visited.Contains((x, y)))
                continue;

            if (grid[y][x] == 'E')
                return steps;

            if (steps == max)
                continue;

            visited.Add((x, y));

            foreach (var (dx, dy) in new[] { (1, 0), (-1, 0), (0, 1), (0, -1) })
            {
                var newX = x + dx;
                var newY = y + dy;

                if (grid[newY][newX] != '#')
                    positions.AddLast((newX, newY, steps + 1));
            }
        }

        return -1;
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
