internal class Day2 : IPuzzle
{
    public string Part1(string input)
    {
        var safe = 0;
        foreach (var line in input.Split('\n'))
        {
            var data = line.Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToArray();
            var safeRow = true;
            var incrementing = data[0] < data[1];
            for (var i = 1; i < data.Length; i++)
            {
                var diff = incrementing
                    ? data[i] - data[i - 1]
                    : data[i - 1] - data[i];

                if (diff < 1 || diff > 3)
                {
                    safeRow = false;
                }
            }
            if (safeRow)
                safe++;
        }

        return safe.ToString();
    }

    public string Part2(string input)
    {
        return string.Empty;
    }
}
