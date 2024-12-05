internal class Day5 : IPuzzle
{
    public string Part1(string input)
    {
        var before = new Dictionary<int, List<int>>();
        var after = new Dictionary<int, List<int>>();
        var lines = input.Split('\n');
        var i = 0;
        for (; i < lines.Length; i++)
        {
            var line = lines[i].Trim();
            if (line.Length == 0)
            {
                i++;
                break;
            }

            var info = line.Split('|').Select(int.Parse).ToArray();
            var left = info[0];
            var right = info[1];

            if (!before.ContainsKey(right))
                before[right] = new List<int>();
            before[right].Add(left);

            if (!after.ContainsKey(left))
                after[left] = new List<int>();
            after[left].Add(right);
        }

        var total = 0;

        for (; i < lines.Length; i++)
        {
            var line = lines[i].Trim();
            var numbers = line.Split(',', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToArray();
            var isValid = true;
            for (var j = 0; j < numbers.Length && isValid; j++)
            {
                var number = numbers[j];
                for (var k = j + 1; k < numbers.Length && isValid; k++)
                {
                    var otherNumber = numbers[k];
                    if (before.TryGetValue(otherNumber, out var beforeNumbers) && !beforeNumbers.Contains(number))
                        isValid = false;
                }

                for (var k = 0; k < j && isValid; k++)
                {
                    var otherNumber = numbers[k];
                    if (after.TryGetValue(otherNumber, out var afterNumbers) && !afterNumbers.Contains(number))
                        isValid = false;
                }
            }

            if (isValid)
                total += numbers[numbers.Length / 2];
        }
        return total.ToString();
    }

    public string Part2(string input)
    {
        return "part 2";
    }
}
