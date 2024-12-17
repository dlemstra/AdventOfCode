internal sealed class Day17 : IPuzzle
{
    public string Part1(string input)
    {
        var lines = input.Split('\n', StringSplitOptions.RemoveEmptyEntries).ToArray();

        var a = int.Parse(lines[0].Split(": ")[1]);
        var b = int.Parse(lines[1].Split(": ")[1]);
        var c = int.Parse(lines[2].Split(": ")[1]);
        var instructions = lines[3].Split(": ")[1].Split(',').Select(int.Parse).ToArray();

        var i = 0;
        var output = new List<int>();
        while (i < instructions.Length - 1)
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
                    a = (int)(a / Math.Pow(2, combo));
                    break;
                case 1:
                    b = b ^ literal;
                    break;
                case 2:
                    b = combo % 8;
                    break;
                case 3:
                    if (a != 0)
                        i = literal;
                    break;
                case 4:
                    b = b ^ c;
                    break;
                case 5:
                    output.Add(combo % 8);
                    break;
                case 6:
                    b = (int)(a / Math.Pow(2, combo));
                    break;
                case 7:
                    c = (int)(a / Math.Pow(2, combo));
                    break;
            }
        }

        return string.Join(",", output);
    }

    public string Part2(string input)
    {
        return "Not implemented";
    }
}
