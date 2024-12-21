using System.Text;

internal sealed class Day21 : Puzzle
{
    public override Task<string> Part1(string input)
        => GetKeyPresses(input, 2);

    public override Task<string> Part2(string input)
        => GetKeyPresses(input, 25);

    private async Task<string> GetKeyPresses(string input, int maxDepth)
    {
        var robotA = new char[][]
        {
            ['7', '8', '9'],
            ['4', '5', '6'],
            ['1', '2', '3'],
            [' ', '0', 'A'],
        };

        var pathsRobotA = FindPaths(robotA);

        var robotB = new char[][]
        {
            [' ', '^', 'A'],
            ['<', 'v', '>'],
        };

        var pathsRobotB = FindPaths(robotB);

        var calculated = new Dictionary<(string, int), long>();

        var total = 0L;
        foreach (var line in input.Split('\n'))
        {
            var code = line.Trim();

            var length = 0L;
            var positionA = 'A';
            foreach (var number in code)
            {
                var paths = pathsRobotA[$"{positionA}{number}"];

                var best = long.MaxValue;
                foreach (var path in paths)
                {
                    var keyPresses = GetKeyPresses(robotB, path + "A", pathsRobotB, calculated, maxDepth);
                    if (keyPresses < best)
                        best = keyPresses;
                }

                length += best;

                positionA = number;
            }

            total += length * int.Parse(code.Replace("A", string.Empty));
            await SetIntermediateResult(total);
        }

        return total.ToString();
    }

    private static long GetKeyPresses(char[][] grid, string keys, IReadOnlyDictionary<string, string[]> paths, Dictionary<(string, int), long> calculated, int maxDepth, int depth = 0)
    {
        if (depth == maxDepth)
            return keys.Length;

        if (calculated.TryGetValue((keys, depth), out var total))
            return total;

        var position = 'A';
        foreach (var key in keys)
        {
            if (position == key)
            {
                total += GetKeyPresses(grid, "A", paths, calculated, maxDepth, depth + 1);
            }
            else
            {
                var best = long.MaxValue;
                foreach (var path in paths[$"{position}{key}"])
                {
                    var keyPresses = GetKeyPresses(grid, path + "A", paths, calculated, maxDepth, depth + 1);
                    if (keyPresses < best)
                        best = keyPresses;
                }

                total += best;
            }

            position = key;
        }

        calculated[(keys, depth)] = total;

        return total;
    }

    private static IReadOnlyDictionary<string, string[]> FindPaths(char[][] grid)
    {
        var values = grid.SelectMany(innerArray => innerArray).Where(c => c != ' ').ToArray();
        var positions = GetPositions(grid, values);
        var (spaceX, spaceY) = GetPositions(grid, [' '])[' '];

        var paths = new Dictionary<string, string[]>();
        for (var i = 0; i < values.Length; i++)
        {
            for (var j = 0; j < values.Length; j++)
            {
                if (i == j)
                {
                    continue;
                }

                var (startX, startY) = positions[values[i]];
                var (endX, endY) = positions[values[j]];
                var key = $"{values[i]}{values[j]}";

                var path = new string(Enumerable.Repeat(startX < endX ? '>' : '<', Math.Abs(startX - endX)).ToArray());
                if (startY == endY)
                {
                    paths.Add(key, [path]);
                }
                else
                {
                    var move = new string(Enumerable.Repeat(startY < endY ? 'v' : '^', Math.Abs(startY - endY)).ToArray());
                    if (startX == endX)
                    {
                        paths.Add(key, [move]);
                    }
                    else if (startX < endX)
                    {
                        if (startX == spaceX && endY == spaceY)
                            paths.Add(key, [path + move]);
                        else
                            paths.Add(key, [path + move, move + path]);
                    }
                    else
                    {
                        if (startY == spaceY && endX == spaceX)
                            paths.Add(key, [move + path]);
                        else
                            paths.Add(key, [move + path, path + move]);
                    }
                }
            }
        }

        return paths;
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
