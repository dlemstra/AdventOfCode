using System.Runtime.InteropServices.JavaScript;

public partial class JavascriptExports
{
    private static readonly IReadOnlyList<IPuzzle> _puzzles = [
        new Day1(),
        new Day2(),
        new Day3(),
        new Day4(),
        new Day5(),
    ];

    [JSExport]
    internal static string GetPuzzleResult(int day, int part, string input)
    {
        if (day < 1 || day > _puzzles.Count)
            return $"Invalid day: {day}"; ;

        var puzzle = _puzzles[day - 1];
        return part switch
        {
            1 => puzzle.Part1(input),
            2 => puzzle.Part2(input),
            _ => $"Invalid part: {part}",
        };
    }
}
