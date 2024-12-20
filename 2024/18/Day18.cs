internal sealed class Day18 : Puzzle
{
    public override Task<string> Part1(string input)
    {
        var fallingBytes = CreateFallingBytes(input);
        var steps = GetStepCount(fallingBytes, 1024);
        if (steps is null)
            return Task.FromResult("Not found");

        return ToString(steps.Value);
    }

    public override Task<string> Part2(string input)
    {
        var fallingBytes = CreateFallingBytes(input);

        var lastSuccess = 0;

        var min = 0;
        var max = fallingBytes.Length;
        while (min < max)
        {
            var maxFailingBytes = (min + max) / 2 + 1;

            if (GetStepCount(fallingBytes, maxFailingBytes) is null)
            {
                max = maxFailingBytes - 1;
                continue;
            }

            min = maxFailingBytes;
            lastSuccess = maxFailingBytes;
        }

        var fallingByte = fallingBytes[lastSuccess];

        return Task.FromResult($"{fallingByte.Item1},{fallingByte.Item2}");
    }

    private static (int, int)[] CreateFallingBytes(string input)
        => input
            .Split('\n')
            .Select(s => s.Split(','))
            .Select(s => (int.Parse(s[0]), int.Parse(s[1])))
            .ToArray();

    private static int? GetStepCount((int, int)[] fallingBytes, int maxFallingBytes)
    {
        var visited = new Dictionary<(int, int), int>();
        var positions = new LinkedList<(int, int, int, HashSet<(int, int)>)>();
        positions.AddLast((0, 0, 0, []));

        int? best = null;
        var bestMoves = new HashSet<(int, int)>();
        while (positions.Count > 0)
        {
            var (x, y, steps, moves) = positions.Last();
            positions.RemoveLast();

            if (x == 70 && y == 70)
            {
                if (best is null || steps < best)
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

            foreach (var (newX, newY) in FindNextMoves(x, y, steps + 1, fallingBytes, maxFallingBytes))
            {
                positions.AddFirst((newX, newY, steps + 1, newMoves));
            }
        }

        return best;
    }

    private static IEnumerable<(int, int)> FindNextMoves(int x, int y, int step, (int, int)[] fallingBytes, int maxFallingBytes)
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
