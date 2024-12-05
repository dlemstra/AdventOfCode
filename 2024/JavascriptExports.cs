using System.Runtime.InteropServices.JavaScript;

public partial class JavascriptExports
{
    private static readonly Dictionary<int, IPuzzle> _puzzles = new()
    {
        { 1, new Day1() },
        { 2, new Day2() },
        { 3, new Day3() },
        { 4, new Day4() },
    };

    [JSExport]
    internal static string GetPuzzleResult(int day, int part, string input)
    {
        if (!_puzzles.TryGetValue(day, out var puzzle))
            return $"Invalid day: {day}";

        return part switch
        {
            1 => puzzle.Part1(input),
            2 => puzzle.Part2(input),
            _ => $"Invalid part: {part}",
        };
    }
}
