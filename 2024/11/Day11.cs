internal class Day11 : IPuzzle
{
    public string Part1(string input)
        => StonesCount(input, 25);

    public string Part2(string input)
        => StonesCount(input, 75);

    private string StonesCount(string input, int times)
    {
        var items = new LinkedList<long>(input.Trim().Split(' ').Select(long.Parse));

        Dictionary<(long, int), long> visited = new();

        var total = 0L;
        foreach (var item in items)
        {
            var count = NumberCount(visited, item, times);
            total += count;
        }

        return total.ToString();
    }

    private long NumberCount(Dictionary<(long, int), long> visited, long number, int times)
    {
        if (times == 0)
            return 1;

        var key = (number, times);

        if (visited.TryGetValue(key, out var value))
            return value;

        if (number == 0)
        {
            var count = NumberCount(visited, 1, times - 1);
            visited[key] = count;
            return count;
        }

        var (first, second) = SplitNumber(number);
        if (first != -1)
        {
            var count = NumberCount(visited, first, times - 1);
            count += NumberCount(visited, second, times - 1);

            visited[key] = count;

            return count;
        }
        else
        {
            var count = NumberCount(visited, number * 2024, times - 1);
            visited[key] = count;
            return count;
        }
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
