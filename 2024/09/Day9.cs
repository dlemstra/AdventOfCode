internal class Day9 : IPuzzle
{
    public string Part1(string input)
    {
        var numbers = input.Trim().ToCharArray().Select(c => (int)c - 48).ToArray();

        var number = 0;
        var id = 0;
        var firstIndex = 0;
        var lastIndex = numbers.Length - 1;
        var lastValue = lastIndex / 2;
        var lastTimes = numbers[lastIndex];

        long total = 0;
        while (firstIndex < lastIndex)
        {
            var times = numbers[firstIndex++];
            for (var i = 0; i < times; i++)
            {
                total += id * number;
                id++;
            }
            number++;

            if (firstIndex == lastIndex)
            {
                break;
            }

            times = numbers[firstIndex++];
            for (var i = 0; i < times; i++)
            {
                if (lastTimes == 0)
                {
                    lastIndex -= 2;
                    if (firstIndex >= lastIndex)
                        break;

                    lastValue--;
                    lastTimes = numbers[lastIndex];
                }

                total += id * lastValue;
                id++;
                lastTimes--;
            }
        }

        for (var i = 0; i < lastTimes; i++)
        {
            total += id * lastValue;
            id++;
        }

        return total.ToString();
    }

    public string Part2(string input)
    {
        return "Not implemented";
    }
}
