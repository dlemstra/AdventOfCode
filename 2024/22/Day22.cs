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

    public override Task<string> Part2(string input)
    {
        return Task.FromResult("Not implemented");
    }
}
