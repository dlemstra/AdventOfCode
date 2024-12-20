internal class Day7 : Puzzle
{
    public override async Task<string> Part1(string input)
    {
        long total = 0;
        foreach (var line in input.Split('\n'))
        {
            var info = line.Split(": ");
            var number = long.Parse(info[0]);
            var numbers = info[1].Split(" ").Select(long.Parse).ToArray();

            if (IsValid(numbers[0], 1, numbers, number))
            {
                total += number;
                await SetIntermediateResult(total);
            }
        }

        return total.ToString();
    }

    public override async Task<string> Part2(string input)
    {
        long total = 0;
        foreach (var line in input.Split('\n'))
        {
            var info = line.Split(": ");
            var number = long.Parse(info[0]);
            var numbers = info[1].Split(" ").Select(long.Parse).ToArray();

            if (IsValid2(numbers[0], 1, numbers, number))
            {
                total += number;
                await SetIntermediateResult(total);
            }
        }

        return total.ToString();
    }

    private bool IsValid(long number, int index, long[] numbers, long result)
    {
        if (number > result)
            return false;

        if (index == numbers.Length)
            return number == result;

        if (IsValid(number + numbers[index], index + 1, numbers, result))
            return true;

        if (IsValid(number * numbers[index], index + 1, numbers, result))
            return true;

        return false;
    }

    private bool IsValid2(long number, int index, long[] numbers, long result)
    {
        if (number > result)
            return false;

        if (index == numbers.Length)
            return number == result;

        if (IsValid2(number + numbers[index], index + 1, numbers, result))
            return true;

        if (IsValid2(number * numbers[index], index + 1, numbers, result))
            return true;

        var right = numbers[index];
        while (right != 0)
        {
            number *= 10;
            right /= 10;
        }

        if (IsValid2(number + numbers[index], index + 1, numbers, result))
            return true;

        return false;
    }
}
