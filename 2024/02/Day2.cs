internal class Day2 : IPuzzle
{
    public string Part1(string input)
    {
        var safe = 0;
        foreach (var line in input.Split('\n'))
        {
            var data = line.Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToArray();
            if (isSafeRow(data))
                safe++;
        }

        return safe.ToString();
    }

    public string Part2(string input)
    {
        var safe = 0;
        foreach (var line in input.Split('\n'))
        {
            var data = line.Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToArray();
            if (isSafeRow(data))
            {
                safe++;
            }
            else
            {
                var old = safe;
                for (var skip = 0; skip < data.Length; skip++)
                {
                    if (isSafeRow(data, skip))
                    {
                        safe++;
                        break;
                    }
                }
            }
        }

        return safe.ToString();
    }

    private bool isSafeRow(int[] data, int skip = -1)
    {
        var incrementing = data[0] < data[1];
        if (skip == 0)
            incrementing = data[1] < data[2];
        else if (skip == 1)
            incrementing = data[0] < data[2];

        var lastIndex = data.Length - 1;
        for (var i = 1; i < data.Length; i++)
        {
            var left = incrementing ? i : i - 1;
            var right = incrementing ? i - 1 : i;

            if (skip == i)
            {
                continue;
            }
            else if (skip == i - 1)
            {
                if (i == 1)
                    continue;

                left = incrementing ? i : i - 2;
                right = incrementing ? i - 2 : i;
            }

            var diff = data[left] - data[right];

            if (diff < 1 || diff > 3)
                return false;
        }

        return true;
    }
}
