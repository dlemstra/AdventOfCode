internal class Day9 : Puzzle
{
    public override Task<string> Part1(string input)
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

        return ToString(total);
    }

    public override Task<string> Part2(string input)
    {
        var numbers = input.Trim().ToCharArray().Select(c => (int)c - 48).ToArray();
        var total = 0L;

        var id = 0;
        var sets = new List<(int, List<int>)>();
        for (var i = 0; i < numbers.Length; i++, id++)
        {
            sets.Add((0, Enumerable.Repeat(id, numbers[i++]).ToList()));
            if (i < numbers.Length)
                sets.Add((numbers[i], new List<int>(numbers[i])));
        }

        var start = 1;
        var end = sets.Count - 1;

        for (var i = sets.Count - 1; i >= 1; i -= 2)
        {
            var (_, valuesToMove) = sets[i];
            for (var j = start; j < i; j += 2)
            {
                var (available, values) = sets[j];
                if (available >= valuesToMove.Count)
                {
                    values.AddRange(valuesToMove);
                    available -= valuesToMove.Count;

                    if (available == 0 && start == j)
                        start = j + 2;

                    if (i == end)
                        end -= 2;

                    sets[i] = (valuesToMove.Count, []);
                    sets[j] = (available, values);
                    break;
                }
            }
        }
        end += 4;

        id = 0;
        foreach (var (available, values) in sets)
        {
            foreach (var value in values)
            {
                total += id++ * value;
            }

            id += available;
        }

        return ToString(total);
    }
}
