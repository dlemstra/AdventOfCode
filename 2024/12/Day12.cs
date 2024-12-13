internal sealed class Day12 : IPuzzle
{
    public string Part1(string input)
    {
        var visited = new HashSet<(int, int)>();

        var grid = LoadGrid(input);

        var total = 0;

        for (var y = 0; y < grid.Length; y++)
        {
            for (var x = 0; x < grid[y].Length; x++)
            {
                var (area, fences) = CalculateAreaAndFences(grid, x, y, grid[y][x], visited);
                if (area > 0 && fences > 0)
                {
                    total += area * fences;
                }
            }
        }

        return total.ToString();
    }

    public string Part2(string input)
    {
        return "Not implemented";
    }

    private char[][] LoadGrid(string input)
    {
        var lines = input.Split('\n');
        var grid = new char[lines.Length][];

        var y = 0;
        foreach (var line in lines)
            grid[y++] = line.Trim().ToCharArray();

        return grid;
    }

    private (int, int) CalculateAreaAndFences(char[][] grid, int x, int y, char value, HashSet<(int, int)> visited)
    {
        if (x < 0 || y < 0 || x >= grid[0].Length || y >= grid.Length)
            return (0, 1);

        if (grid[y][x] != value)
            return (0, 1);

        if (visited.Contains((x, y)))
            return (0, 0);

        visited.Add((x, y));

        var area = 1;
        var fences = 0;

        (int, int)[] directions = [(-1, 0), (0, -1), (1, 0), (0, 1)];

        foreach (var (dx, dy) in directions)
        {
            var (a, b) = CalculateAreaAndFences(grid, x + dx, y + dy, value, visited);
            area += a;
            fences += b;
        }

        return (area, fences);
    }
}
