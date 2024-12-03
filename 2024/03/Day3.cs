internal class Day3 : IPuzzle
{
    public string Part1(string input)
    {
        var total = 0;
        var index = 0;
        var stage = Stage.Start;
        var left = -1;
        var right = -1;

        while (index != -1 && index < input.Length)
        {
            switch (stage)
            {
                case Stage.Start:
                    index = input.IndexOf("mul(", index);
                    if (index != -1)
                        index += 4;

                    stage = Stage.Left;
                    left = -1;
                    right = -1;
                    break;
                case Stage.Left:
                    if (int.TryParse(new string([input[index]]), out var leftNumber))
                    {
                        left = left == -1 ? 0 : left *= 10;
                        left += leftNumber;
                    }
                    else if (left != -1 && input[index] == ',')
                    {
                        stage = Stage.Right;
                    }
                    else
                    {
                        stage = Stage.Start;
                    }
                    index++;
                    break;
                case Stage.Right:
                    if (int.TryParse(new string([input[index]]), out var rightNumber))
                    {
                        right = right == -1 ? 0 : right *= 10;
                        right += rightNumber;
                    }
                    else
                    {
                        if (right != -1 && input[index] == ')')
                            total += left * right;
                        stage = Stage.Start;
                    }
                    index++;
                    break;
            }
        }

        return total.ToString();
    }

    public string Part2(string input)
    {
       return string.Empty;
    }
}

enum Stage
{
    Start,
    Left,
    Right,
    End,
}
