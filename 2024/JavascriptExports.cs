using System.Runtime.InteropServices.JavaScript;

public partial class JavascriptExports
{
    private static readonly IReadOnlyList<IPuzzle> _puzzles = [
        new Day1(),
        new Day2(),
        new Day3(),
        new Day4(),
        new Day5(),
        new Day6(),
        new Day7(),
    ];

    [JSExport]
    internal static async Task<string> GetPuzzleResult(int day, int part, string input)
    {
        if (day < 1 || day > _puzzles.Count)
            return $"Invalid day: {day}";

        return await Task.Run(() => ExecutePuzzle(_puzzles[day - 1], part, input));
    }

    private static string ExecutePuzzle(IPuzzle puzzle, int part, string input)
        => part switch
        {
            1 => puzzle.Part1(input),
            2 => puzzle.Part2(input),
            _ => $"Invalid part: {part}",
        };
}
