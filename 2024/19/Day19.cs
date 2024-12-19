internal sealed class Day19 : IPuzzle
{
    public string Part1(string input)
    {
        var info = input.Split("\n");
        var patterns = info[0].Trim().Split(", ").ToList();
        patterns.Sort((a, b) => b.Length.CompareTo(a.Length));

        var total = 0L;
        var calculated = new Dictionary<string, long>();
        for (var i = 2; i < info.Length; i++)
        {
            var towel = info[i].Trim();
            var count = PossibleCount(towel, patterns, calculated);

            if (count != 0)
                total += 1;
        }

        return total.ToString();
    }

    public string Part2(string input)
    {
        var info = input.Split("\n");
        var patterns = info[0].Trim().Split(", ").ToList();
        patterns.Sort((a, b) => b.Length.CompareTo(a.Length));

        var total = 0L;
        var calculated = new Dictionary<string, long>();
        for (var i = 2; i < info.Length; i++)
        {
            var towel = info[i].Trim();
            total += PossibleCount(towel, patterns, calculated);
        }

        return total.ToString();
    }

    private long PossibleCount(string value, List<string> patterns, Dictionary<string, long> calculated)
    {
        if (value.Length == 0)
            return 1;

        if (calculated.TryGetValue(value, out var count))
            return count;

        foreach (var pattern in patterns)
        {
            if (!value.StartsWith(pattern))
                continue;

            var remaining = value.Substring(pattern.Length);
            count += PossibleCount(remaining, patterns, calculated);
        }

        calculated.Add(value, count);

        return count;
    }
}
