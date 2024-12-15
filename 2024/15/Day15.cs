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
                    if (tryMoveBox1(grid, nextX, nextY, move))
                    {
                        x = nextX;
                        y = nextY;
                    }
                    break;
                default:
                    break;
            }
        }

        return GetSum(grid, 'O');
    }

    public string Part2(string input)
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

            List<char> line = [];
            foreach (var c in lines[i].ToCharArray())
            {
                switch (c)
                {
                    case '#':
                        line.AddRange(['#', '#']);
                        break;
                    case 'O':
                        line.AddRange(['[', ']']);
                        break;
                    case '.':
                        line.AddRange(['.', '.']);
                        break;
                    case '@':
                        x = line.Count;
                        y = i;
                        line.AddRange(['.', '.']);
                        break;
                }
            }

            grid[i] = line.ToArray();
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
                case '[':
                case ']':
                    if (tryMoveBox2(grid, nextX, nextY, move))
                    {
                        x = nextX;
                        y = nextY;
                    }
                    break;
            }
        }

        return GetSum(grid, '[');
    }

    private static bool tryMoveBox1(char[][] grid, int x, int y, char move)
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

    private static bool tryMoveBox2(char[][] grid, int x, int y, char move)
    {
        var (dX, dY) = GetIncrement(move);

        if (dY == 0)
        {
            var endX = x + dX;
            while (grid[y][endX] == '[' || grid[y][endX] == ']')
            {
                endX += dX;
            }

            if (grid[y][endX] != '.')
                return false;

            var x1 = endX;
            var x2 = x;
            while (x1 != x2)
            {
                grid[y][x1] = grid[y][x1 - dX];
                x1 -= dX;
            }

            grid[y][x] = '.';

            return true;
        }
        else
        {
            var boxes = FindBoxes(grid, x, y, dY).Distinct().ToList();

            boxes.Sort((a, b) =>
            {
                if (a.Item2 == b.Item2)
                    return a.Item1.CompareTo(b.Item1);
                return a.Item2.CompareTo(b.Item2);
            });

            var canMove = true;

            foreach (var (boxX, boxY) in boxes)
            {
                if (grid[boxY + dY][boxX] == '#' || grid[boxY + dY][boxX + 1] == '#')
                {
                    canMove = false;
                    break;
                }
            }

            if (!canMove)
                return false;

            if (dY == 1)
                boxes.Reverse();

            foreach (var (boxX, boxY) in boxes)
            {
                grid[boxY + dY][boxX] = '[';
                grid[boxY + dY][boxX + 1] = ']';
                grid[boxY][boxX] = '.';
                grid[boxY][boxX + 1] = '.';
            }

            return true;
        }
    }

    private static IEnumerable<(int, int)> FindBoxes(char[][] grid, int x, int y, int dY)
    {
        var minX = x;
        var maxX = x;
        if (grid[y][minX] == '[')
            maxX = x + 1;
        else if (grid[y][maxX] == ']')
            minX = x - 1;
        else
            yield break;

        yield return (minX, y);

        foreach (var boxes in FindBoxes(grid, minX, y + dY, dY))
        {
            yield return boxes;
        }

        foreach (var boxes in FindBoxes(grid, maxX, y + dY, dY))
        {
            yield return boxes;
        }
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

    private static string GetSum(char[][] grid, char box)
    {
        var total = 0;
        for (var yy = 0; yy < grid.Length; yy++)
        {
            for (var xx = 0; xx < grid[yy].Length; xx++)
            {
                if (grid[yy][xx] == box)
                    total += 100 * yy + xx;

            }
        }

        return total.ToString();
    }
}
