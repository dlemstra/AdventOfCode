internal class Day1 : Puzzle
{
    public override Task<string> Part1(string input)
    {
        var (listA, listB) = ReadInput(input);

        var total = 0;
        for (var i = 0; i < listA.Count; i++)
        {
            total += Math.Abs(listA[i] - listB[i]);
        }

        return ToString(total);
    }

    public override async Task<string> Part2(string input)
    {
        var (listA, listB) = ReadInput(input);

        var total = 0;
        var start = 0;
        for (var i = 0; i < listA.Count; i++)
        {
            var a = listA[i];

            var count = 0;
            for (var j = start; j < listB.Count; j++)
            {
                var b = listB[j];

                if (a == b)
                {
                    count++;
                    total += a;
                }
                else if (b > a)
                {
                    start = j - count;
                    break;
                }
            }

            await SetIntermediateResult(total);
        }

        return total.ToString();
    }

    private static (List<int>, List<int>) ReadInput(string input)
    {
        var listA = new List<int>();
        var listB = new List<int>();
        foreach (var line in input.Split('\n'))
        {
            var numbers = line.Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList();

            listA.Add(numbers[0]);
            listB.Add(numbers[1]);
        }

        listA.Sort();
        listB.Sort();
        return (listA, listB);
    }
}
