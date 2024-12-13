internal sealed class Day12 : IPuzzle
{
    public string Part1(string input)
    {
        var grid = LoadGrid(input);

        var total = 0;

        foreach (var (area, fences) in CalculateAreaAndFences(grid))
            total += area * fences.Count;

        return total.ToString();
    }

    public string Part2(string input)
    {
        var grid = LoadGrid(input);

        var total = 0;

        foreach (var (area, fences) in CalculateAreaAndFences(grid))
        {
            var longFences = 0;

            fences.Sort((a, b) =>
            {
                if (a.Item1 == b.Item1)
                    return a.Item2.CompareTo(b.Item2);
                return a.Item1.CompareTo(b.Item1);
            });

            for (var i = 0; i < fences.Count; i++)
            {
                var (x1, y1, dx1, dy1) = fences[i];

                var matches = false;
                for (var j = i + 1; j < fences.Count; j++)
                {
                    var (x2, y2, dx2, dy2) = fences[j];

                    if (dx1 != dx2 || dy1 != dy2)
                        continue;

                    if (x1 == x2 && Math.Abs(y1 - y2) == 1)
                    {
                        matches = true;
                        break;
                    }

                    if (y1 == y2 && Math.Abs(x1 - x2) == 1)
                    {
                        matches = true;
                        break;
                    }
                }

                if (!matches)
                    longFences++;
            }

            total += area * longFences;
        }

        return total.ToString();
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

    private IEnumerable<(int, List<(int, int, int, int)>)> CalculateAreaAndFences(char[][] grid)
    {
        var visited = new HashSet<(int, int)>();
        for (var y = 0; y < grid.Length; y++)
        {
            for (var x = 0; x < grid[y].Length; x++)
            {
                var fences = new List<(int, int, int, int)>();
                var area = CalculateAreaAndFences(grid, x, y, grid[y][x], visited, fences);
                if (area > 0)
                    yield return (area, fences);
            }
        }
    }

    private int CalculateAreaAndFences(char[][] grid, int x, int y, char value, HashSet<(int, int)> visited, List<(int, int, int, int)> fences)
    {
        if (visited.Contains((x, y)))
            return 0;

        visited.Add((x, y));

        var area = 1;

        (int, int)[] directions = [(-1, 0), (0, -1), (1, 0), (0, 1)];
        foreach (var (dx, dy) in directions)
        {
            if (GetValue(grid, x + dx, y + dy) != value)
                fences.Add((x, y, dx, dy));
            else
                area += CalculateAreaAndFences(grid, x + dx, y + dy, value, visited, fences);
        }

        return area;
    }

    private char GetValue(char[][] grid, int x, int y)
    {
        if (x < 0 || y < 0 || x >= grid[0].Length || y >= grid.Length)
            return ' ';
        return grid[y][x];
    }
}
