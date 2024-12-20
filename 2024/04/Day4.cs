internal class Day4 : Puzzle
{
    public override async Task<string> Part1(string input)
    {
        var grid = LoadGrid(input);

        var total = 0;
        var remaining = "MAS";
        for (var y = 0; y < grid.Length; y++)
        {
            var row = grid[y];
            for (var x = 0; x < row.Length; x++)
            {
                if (grid[y][x] == 'X')
                {
                    total += matchCount(ref grid, x, y, 0, -1, remaining);
                    total += matchCount(ref grid, x, y, 0, 1, remaining);
                    total += matchCount(ref grid, x, y, 1, -1, remaining);
                    total += matchCount(ref grid, x, y, 1, 1, remaining);
                    total += matchCount(ref grid, x, y, 1, 0, remaining);
                    total += matchCount(ref grid, x, y, -1, -1, remaining);
                    total += matchCount(ref grid, x, y, -1, 1, remaining);
                    total += matchCount(ref grid, x, y, -1, 0, remaining);
                }
            }

            await SetIntermediateResult(total);
        }

        return total.ToString();
    }

    public override async Task<string> Part2(string input)
    {
        var grid = LoadGrid(input);

        var total = 0;
        for (var y = 0; y < grid.Length; y++)
        {
            var row = grid[y];
            for (var x = 0; x < row.Length; x++)
            {
                if (grid[y][x] == 'A' &&
                    ((matchCount(ref grid, x, y, -1, -1, "M") == 1 && matchCount(ref grid, x, y, 1, 1, "S") == 1) ||
                     (matchCount(ref grid, x, y, -1, -1, "S") == 1 && matchCount(ref grid, x, y, 1, 1, "M") == 1)) &&
                    ((matchCount(ref grid, x, y, 1, -1, "M") == 1 && matchCount(ref grid, x, y, -1, 1, "S") == 1) ||
                     (matchCount(ref grid, x, y, 1, -1, "S") == 1 && matchCount(ref grid, x, y, -1, 1, "M") == 1)))
                        total++;
            }

            await SetIntermediateResult(total);
        }

        return await ToString(total);
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

    private int matchCount(ref char[][] grid, int x, int y, int xIncrement, int yIncrement, string match)
    {
        var newX = x + xIncrement;
        var newY = y + yIncrement;

        if (newY < 0 || newY > grid.Length - 1 || newX < 0 || newX > grid[0].Length - 1)
            return 0;

        if (grid[newY][newX] != match[0])
            return 0;

        if (match.Length == 1)
            return 1;

        var remaining = match.Substring(1);
        return matchCount(ref grid, newX, newY, xIncrement, yIncrement, remaining);
    }
}
