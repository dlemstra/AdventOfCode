internal class Day11 : IPuzzle
{
    public string Part1(string input)
    {
        var items = new LinkedList<long>(input.Trim().Split(' ').Select(long.Parse));

        for (var i = 0; i < 25; i++)
        {
            var item = items.First;
            while (item != null)
            {
                if (item.Value == 0)
                {
                    item.Value = 1;
                    item = item.Next;
                    continue;
                }

                var (first, second) = SplitNumber(item.Value);
                if (first != -1)
                {
                    item.Value = first;
                    items.AddAfter(item, second);
                    item = item.Next!.Next;
                    continue;
                }

                item.Value *= 2024;
                item = item.Next;
            }
        }

        return items.Count.ToString();
    }

    public string Part2(string input)
    {
        return "Not implemented";
    }

    private (long, long) SplitNumber(long number)
    {
        var digitCount = (int)Math.Log10(number) + 1;

        if (digitCount % 2 != 0)
            return (-1, -1);

        var divisor = (int)Math.Pow(10, digitCount / 2);

        return (number / divisor, number % divisor);
    }
}
