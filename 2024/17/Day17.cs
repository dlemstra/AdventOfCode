internal sealed class Day17 : IPuzzle
{
    public string Part1(string input)
    {
        var (a, b, c, instructions) = LoadInstructions(input);

        return string.Join(",", GetOutput(a, b, c, instructions));
    }

    public string Part2(string input)
    {
        var (a, b, c, instructions) = LoadInstructions(input);

        var options = new LinkedList<(long, int)>();
        options.AddLast((0, instructions.Length - 1));

        while (options.Count > 0)
        {
            var (value, index) = options.First();
            options.RemoveFirst();

            for (var i = 0; i < 8; i++)
            {
                var newA = value + i;
                var output = GetOutput(newA, b, c, instructions);
                if (output[0] != instructions[index])
                    continue;

                if (index == 0)
                    return newA.ToString();

                options.AddLast((newA * 8, index - 1));
            }
        }

        return "Not found";
    }

    private static (long, long, long, long[]) LoadInstructions(string input)
    {
        var lines = input.Split('\n', StringSplitOptions.RemoveEmptyEntries).ToList();

        var a = int.Parse(lines[0].Split(": ")[1]);
        var b = int.Parse(lines[1].Split(": ")[1]);
        var c = int.Parse(lines[2].Split(": ")[1]);
        var instructions = lines[3].Split(": ")[1].Split(',').Select(long.Parse).ToArray();

        return (a, b, c, instructions);
    }

    private static IReadOnlyList<long> GetOutput(long a, long b, long c, IReadOnlyList<long> instructions)
    {
        var i = 0;
        var output = new List<long>();
        while (i < instructions.Count - 1)
        {
            var instruction = instructions[i];
            var literal = instructions[i + 1];
            var combo = literal;
            switch (combo)
            {
                case 4:
                    combo = a;
                    break;
                case 5:
                    combo = b;
                    break;
                case 6:
                    combo = c;
                    break;
            }

            i += 2;
            switch (instruction)
            {
                case 0:
                    a = (long)(a / Math.Pow(2, combo));
                    break;
                case 1:
                    b = b ^ literal;
                    break;
                case 2:
                    b = combo % 8;
                    break;
                case 3:
                    if (a != 0)
                        i = (int)literal;
                    break;
                case 4:
                    b = b ^ c;
                    break;
                case 5:
                    output.Add(combo % 8);
                    break;
                case 6:
                    b = (long)(a / Math.Pow(2, combo));
                    break;
                case 7:
                    c = (long)(a / Math.Pow(2, combo));
                    break;
            }
        }

        return output;
    }
}
