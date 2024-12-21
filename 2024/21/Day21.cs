using System.Text;

internal sealed class Day21 : Puzzle
{
    public override async Task<string> Part1(string input)
    {
        var robotA = new char[][]
        {
            ['7', '8', '9'],
            ['4', '5', '6'],
            ['1', '2', '3'],
            [' ', '0', 'A'],
        };

        var pathsRobotA = FindPaths(robotA, 3);

        var robotB = new char[][]
        {
            [' ', '^', 'A'],
            ['<', 'v', '>'],
        };

        var pathsRobotB = FindPaths(robotB, 0);

        var total = 0;
        foreach (var line in input.Split('\n'))
        {
            var code = line.Trim();
            //var code = "379A";
            var position = 'A';

            var pathA = GetPath(pathsRobotA, code);
            var pathB = GetPath(pathsRobotB, pathA);
            var pathC = GetPath(pathsRobotB, pathB);
            total += pathC.Length * int.Parse(code.Replace("A", ""));

            await SetIntermediateResult(total);
        }

        return total.ToString();
    }

    public override Task<string> Part2(string input)
    {
        return Task.FromResult("Not implemented");
    }

    private static string GetPath(IReadOnlyDictionary<string, string> paths, string code)
    {
        var path = new StringBuilder();

        var position = 'A';
        foreach (var number in code)
        {
            if (paths.TryGetValue($"{position}{number}", out var value))
                path.Append(value);

            path.Append("A");
            position = number;
        }

        return path.ToString();
    }

    private static IReadOnlyDictionary<string, string> FindPaths(char[][] grid, int spaceRow)
    {
        var values = grid.SelectMany(innerArray => innerArray).Where(c => c != ' ').ToArray();
        var positions = GetPositions(grid, values);

        var paths = new Dictionary<string, string>();
        for (var i = 0; i < values.Length; i++)
        {
            for (var j = 0; j < values.Length; j++)
            {
                if (i == j)
                {
                    continue;
                }

                var start = values[i];
                var end = values[j];
                var path = FindPath(grid, positions, start, end, spaceRow);
                paths.Add($"{start}{end}", path);
            }
        }

        return paths;
    }

    private static string FindPath(char[][] grid, IReadOnlyDictionary<char, (int, int)> positions, char start, char end, int spaceRow)
    {
        var (startX, startY) = positions[start];
        var (endX, endY) = positions[end];

        var values = new List<char>();

        var x = startX;
        var y = startY;

        if (endX == 0 && y != spaceRow)
        {
            while (y != endY)
            {
                if (y < endY)
                {
                    y++;
                    values.Add('v');
                }
                else
                {
                    y--;
                    values.Add('^');
                }
            }
        }

        if (x > endX)
        {
            while (x != endX)
            {
                if (x < endX)
                {
                    x++;
                    values.Add('>');
                }
                else
                {
                    x--;
                    values.Add('<');
                }
            }
        }


        while (x != endX || y != endY)
        {
            while (y != endY)
            {
                if (y < endY)
                {
                    y++;
                    values.Add('v');
                }
                else
                {
                    y--;
                    values.Add('^');
                }
            }

            while (x != endX)
            {
                if (x < endX)
                {
                    x++;
                    values.Add('>');
                }
                else
                {
                    x--;
                    values.Add('<');
                }
            }
        }

        return new string(values.ToArray());
    }

    private static IReadOnlyDictionary<char, (int, int)> GetPositions(char[][] grid, char[] values)
    {
        var result = new Dictionary<char, (int, int)>();

        foreach (var value in values)
        {
            for (var y = 0; y < grid.Length; y++)
            {
                var x = Array.IndexOf(grid[y], value);
                if (x != -1)
                {
                    result.Add(value, (x, y));
                    break;
                }
            }
        }

        return result;
    }
}
