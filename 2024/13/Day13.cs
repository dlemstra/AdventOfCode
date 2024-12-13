internal sealed class Day13 : IPuzzle
{
    public string Part1(string input)
    {
        var lines = input.Split('\n');

        var total = 0;

        for (var i = 0; i < lines.Length; i++)
        {
            var aX = int.Parse(lines[i].Split(',')[0].Split('+')[1]);
            var aY = int.Parse(lines[i++].Split('+')[2]);

            var bX = int.Parse(lines[i].Split(',')[0].Split('+')[1]);
            var bY = int.Parse(lines[i++].Split('+')[2]);

            var prizeX = int.Parse(lines[i].Split(',')[0].Split('=')[1]);
            var prizeY = int.Parse(lines[i++].Split('=')[2]);

            var remainingX = prizeX;
            var remainingY = prizeY;
            var tokens = 0;
            for (var aCount = 1; aCount < 101; aCount++)
            {
                remainingX -= aX;
                remainingY -= aY;
                if (remainingX < 0 || remainingY < 0)
                    break;

                if (remainingX % bX == 0 && remainingY % bY == 0)
                {
                    var bCount = remainingY / bY;
                    if (bCount < 100 && remainingX / bX == bCount)
                    {
                        tokens = (aCount * 3) + bCount;
                        break;
                    }
                }
            }
            if (tokens != 0)
                total += tokens;
        }

        return total.ToString();
    }

    public string Part2(string input)
    {
        return "Not implemented";
    }
}
