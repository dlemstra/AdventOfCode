internal sealed class Day15 : IPuzzle
{
    public string Part1(string input)
    {
        var lines = input.Split('\n').Select(l => l.Trim()).ToArray();
        var emptyLine = Array.IndexOf(lines, "");

        char[][] grid = new char[emptyLine][];
        List<char> moves = [];
        int x = 0;
        int y = 0;

        for (var i = 0; i < lines.Length; i++)
        {
            if (i == emptyLine)
                continue;

            if (i > emptyLine)
            {
                moves.AddRange(lines[i].ToCharArray());
                continue;
            }

            grid[i] = lines[i].ToCharArray();

            var pos = lines[i].IndexOf("@");
            if (pos != -1)
            {
                x = pos;
                y = i;
                grid[y][x] = '.';
            }
        }

        foreach (var move in moves)
        {
            var (dX, dY) = GetIncrement(move);

            var nextX = x + dX;
            var nextY = y + dY;

            switch (grid[nextY][nextX])
            {
                case '.':
                    x = nextX;
                    y = nextY;
                    break;
                case 'O':
                    if (tryMoveBox(grid, nextX, nextY, move))
                    {
                        x = nextX;
                        y = nextY;
                    }
                    break;
                default:
                    break;
            }
        }

        return GetSum(grid);
    }

    public string Part2(string input)
    {
        return "Not implemented";
    }

    private static bool tryMoveBox(char[][] grid, int x, int y, char move)
    {
        var (dX, dY) = GetIncrement(move);

        var endX = x + dX;
        var endY = y + dY;
        while (grid[endY][endX] == 'O')
        {
            endX += dX;
            endY += dY;
        }

        if (grid[endY][endX] != '.')
            return false;

        while (x != endX || y != endY)
        {
            grid[endY][endX] = 'O';
            endX -= dX;
            endY -= dY;
        }
        grid[y][x] = '.';

        return true;
    }

    private static (int, int) GetIncrement(char move)
        => move switch
        {
            '^' => (0, -1),
            'v' => (0, 1),
            '<' => (-1, 0),
            '>' => (1, 0),
            _ => (0, 0),
        };

    private static string GetSum(char[][] grid)
    {
        var total = 0;
        for (var yy = 0; yy < grid.Length; yy++)
        {
            for (var xx = 0; xx < grid[yy].Length; xx++)
            {
                if (grid[yy][xx] == 'O')
                    total += 100 * yy + xx;

            }
        }

        return total.ToString();
    }
}
