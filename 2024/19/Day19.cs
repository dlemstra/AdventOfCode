internal sealed class Day19 : IPuzzle
{
    public string Part1(string input)
    {
        var info = input.Split("\n");
        var patterns = info[0].Trim().Split(", ").ToList();
        patterns.Sort((a, b) => b.Length.CompareTo(a.Length));

        var total = 0;
        var possible = new LinkedList<string>();
        for (var i = 2; i < info.Length; i++)
        {
            var towel = info[i].Trim();
            possible.AddLast(towel);

            var found = false;
            while (possible.Count > 0)
            {
                var value = possible.Last();
                possible.RemoveLast();

                foreach (var pattern in patterns)
                {
                    if (!value.StartsWith(pattern))
                        continue;

                    var remaining = value.Substring(pattern.Length);
                    if (remaining.Length == 0)
                    {
                        found = true;
                        possible.Clear();
                        break;
                    }

                    possible.AddLast(remaining);
                }
            }

            if (found)
                total++;
        }

        return total.ToString();
    }

    public string Part2(string input)
    {
        return "Not implemented";
    }
}
