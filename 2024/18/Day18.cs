internal sealed class Day18 : IPuzzle
{
    public string Part1(string input)
    {
        var fallingBytes = input.Split('\n').Select(s => s.Split(','))
           .Select(s => (int.Parse(s[0]), int.Parse(s[1]))).ToArray();

        var visited = new Dictionary<(int, int), int>();
        var positions = new LinkedList<(int, int, int, HashSet<(int, int)>)>();
        positions.AddLast((0, 0, 0, []));

        var best = int.MaxValue;
        var bestMoves = new HashSet<(int, int)>();
        var maxFallingBytes = 1024;
        while (positions.Count > 0)
        {
            var (x, y, steps, moves) = positions.Last();
            positions.RemoveLast();

            if (x == 70 && y == 70)
            {
                if (steps < best)
                {
                    best = steps;
                    bestMoves = moves;
                }
                continue;
            }

            if (visited.TryGetValue((x, y), out var visitedSteps) && visitedSteps <= steps)
                continue;

            visited[(x, y)] = steps;

            var newMoves = new HashSet<(int, int)>(moves);
            newMoves.Add((x, y));

            foreach (var (newX, newY) in findNextMoves(x, y, steps + 1, fallingBytes, maxFallingBytes))
            {
                positions.AddFirst((newX, newY, steps + 1, newMoves));
            }
        }

        return best.ToString();
    }

    public string Part2(string input)
    {
        return "Not implemented";
    }

    private static IEnumerable<(int, int)> findNextMoves(int x, int y, int step, (int, int)[] fallingBytes, int maxFallingBytes)
    {
        foreach (var (dx, dy) in new[] { (1, 0), (-1, 0), (0, 1), (0, -1) })
        {
            var newX = x + dx;
            var newY = y + dy;

            if (newX < 0 || newX > 70 || newY < 0 || newY > 70)
                continue;

            var canMove = true;
            for (var i = 0; i < maxFallingBytes; i++)
            {
                if (fallingBytes[i].Item1 == newX && fallingBytes[i].Item2 == newY)
                {
                    canMove = false;
                    break;
                }
            }

            if (canMove)
                yield return (newX, newY);
        }
    }
}
