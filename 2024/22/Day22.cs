using System.Text;

internal sealed class Day22 : Puzzle
{
    public override async Task<string> Part1(string input)
    {
        var total = 0L;
        foreach (var line in input.Split("\n"))
        {
            long value = long.Parse(line);

            for (var i = 0; i < 2000; i++)
            {
                value = (value ^ (value * 64)) % 16777216;
                value = (value ^ (value / 32)) % 16777216;
                value = (value ^ (value * 2048)) % 16777216;
            }
            total += value;
            await SetIntermediateResult(total);
        }

        return total.ToString();
    }

    public override async Task<string> Part2(string input)
    {
        var best = 0L;
        var sequences = new Dictionary<(long, long, long, long), long>();
        foreach (var line in input.Split("\n"))
        {
            long value = long.Parse(line);

            var a = 0L;
            var b = 0L;
            var c = 0L;
            var d = 0L;

            var digit = value % 10;

            var found = new HashSet<(long, long, long, long)>();
            for (var i = 0; i < 2000; i++)
            {
                value = (value ^ (value * 64)) % 16777216;
                value = (value ^ (value / 32)) % 16777216;
                value = (value ^ (value * 2048)) % 16777216;

                var newDigit = value % 10;
                var delta = newDigit - digit;
                digit = newDigit;

                a = b;
                b = c;
                c = d;
                d = delta;

                if (i >= 3 && digit > 0)
                {
                    var key = (a, b, c, d);
                    if (!found.Add(key))
                        continue;

                    sequences.TryGetValue(key, out var count);
                    count += digit;
                    sequences[key] = count;

                    if (count > best)
                    {
                        best = count;
                        await SetIntermediateResult(best);
                    }
                }
            }
        }

        return best.ToString();
    }
}
