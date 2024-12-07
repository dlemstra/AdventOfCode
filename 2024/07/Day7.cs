internal class Day7 : IPuzzle
{
    public string Part1(string input)
    {
        long total = 0;
        foreach (var line in input.Split('\n'))
        {
            var info = line.Split(": ");
            var number = long.Parse(info[0]);
            var numbers = info[1].Split(" ").Select(long.Parse).ToArray();

            if (IsValid(numbers[0], 1, numbers, number))
                total += number;
        }

        return total.ToString();
    }

    public string Part2(string input)
    {
        return "Not implemented";
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
}
