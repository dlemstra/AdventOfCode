internal class Day10 : Puzzle
{
    public override Task<string> Part1(string input)
    {
        var grid = LoadGrid(input);

        return GetScoreSum(grid, trackVisited: true);
    }

    public override Task<string> Part2(string input)
    {
        var grid = LoadGrid(input);

        return GetScoreSum(grid, trackVisited: false);
    }

    private async Task<string> GetScoreSum(int[][] grid, bool trackVisited)
    {
        var total = 0;
        foreach (var (startX, startY) in GetStartingPositions(grid))
        {
            var steps = new Queue<(int, int, int)>();
            steps.Enqueue((0, startX, startY));

            var visited = new HashSet<(int, int, int)>();
            var found = 0;
            while (steps.Count > 0)
            {
                var (number, x, y) = steps.Dequeue();

                if (trackVisited && !visited.Add((number, x, y)))
                    continue;

                if (number == 9)
                {
                    found++;
                    continue;
                }

                var nextNumber = number + 1;

                if (x - 1 >= 0 && grid[y][x - 1] == nextNumber)
                    steps.Enqueue((nextNumber, x - 1, y));

                if (x + 1 < grid[y].Length && grid[y][x + 1] == nextNumber)
                    steps.Enqueue((nextNumber, x + 1, y));

                if (y - 1 >= 0 && grid[y - 1][x] == nextNumber)
                    steps.Enqueue((nextNumber, x, y - 1));

                if (y + 1 < grid.Length && grid[y + 1][x] == nextNumber)
                    steps.Enqueue((nextNumber, x, y + 1));
            }

            total += found;

            await SetIntermediateResult(total);
        }

        return total.ToString();
    }

    private IEnumerable<(int, int)> GetStartingPositions(int[][] grid)
    {
        for (var y = 0; y < grid.Length; y++)
        {
            var row = grid[y];
            for (var x = 0; x < row.Length; x++)
            {
                if (row[x] == 0)
                    yield return (x, y);
            }
        }
    }

    private int[][] LoadGrid(string input)
    {
        var lines = input.Split('\n');
        var grid = new int[lines.Length][];

        var y = 0;
        foreach (var line in lines)
            grid[y++] = line.Trim().ToCharArray().Select(c => (int)c - 48).ToArray();

        return grid;
    }
}
