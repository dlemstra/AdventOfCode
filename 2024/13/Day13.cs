internal sealed class Day13 : Puzzle
{
    public override Task<string> Part1(string input)
    {
        var lines = input.Split('\n');

        return CalculateTokens(lines, 0, 100);
    }

    public override Task<string> Part2(string input)
    {
        var lines = input.Split('\n');

        return CalculateTokens(lines, 10000000000000, long.MaxValue);
    }

    private async Task<string> CalculateTokens(string[] lines, long addition, long maxTimes)
    {
        var total = 0L;
        for (var i = 0; i < lines.Length; i++)
        {
            var aX = long.Parse(lines[i].Split(',')[0].Split('+')[1]);
            var aY = long.Parse(lines[i++].Split('+')[2]);

            var bX = long.Parse(lines[i].Split(',')[0].Split('+')[1]);
            var bY = long.Parse(lines[i++].Split('+')[2]);

            var prizeX = long.Parse(lines[i].Split(',')[0].Split('=')[1]);
            var prizeY = long.Parse(lines[i++].Split('=')[2]);

            prizeX += addition;
            prizeY += addition;

            var countA = (prizeY * bX - prizeX * bY) / (aY * bX - aX * bY);
            if (countA > maxTimes)
                continue;

            var countB = (prizeY * aX - prizeX * aY) / (bY * aX - bX * aY);
            if (countB > maxTimes)
                continue;

            if ((countA * aX + countB * bX == prizeX) && (countA * aY + countB * bY == prizeY))
            {
                total += (countA * 3) + countB;
                await SetIntermediateResult(total);
            }
        }

        return total.ToString();
    }
}
