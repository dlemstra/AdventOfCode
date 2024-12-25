internal sealed class Day25 : Puzzle
{
    public override Task<string> Part1(string input)
    {
        List<string> lines = input.TrimEnd().Split("\n").Select(l => l.Trim()).ToList();
        lines.Add(string.Empty);

        var locks = new List<int[]>();
        var keys = new List<int[]>();

        var isLock = lines[0][0] == '#';
        var heights = new int[lines[0].Length];
        for (var i = 0; i < lines.Count; i++)
        {
            if (lines[i].Length == 0)
            {
                if (isLock)
                    locks.Add(heights);
                else
                    keys.Add(heights);

                if (i == lines.Count - 1)
                    continue;

                i++;
                isLock = lines[i][0] == '#';
                heights = new int[lines[0].Length];
                continue;
            }

            for (var j = 0; j < heights.Length; j++)
                heights[j] += lines[i][j] == '#' ? 1 : 0;
        }

        var total = 0;
        foreach (var lockHeights in locks)
        {
            foreach (var keyHeights in keys)
            {
                var fits = true;
                for (var j = 0; j < lockHeights.Length; j++)
                {
                    if (lockHeights[j] + keyHeights[j] > 6)
                    {
                        fits = false;
                        break;
                    }
                }

                if (fits)
                    total++;
            }
        }

        return ToString(total);
    }

    public override Task<string> Part2(string input)
        => Task.FromResult("There is no part 2 for this puzzle.");
}
