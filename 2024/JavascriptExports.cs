using System.Reflection;
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
        new Day8(),
        new Day9(),
        new Day10(),
        new Day11(),
        new Day12(),
        new Day13(),
        new Day14(),
        new Day15(),
        new Day16(),
        new Day17(),
        new Day18(),
        new Day19(),
        new Day20(),
    ];

    [JSExport]
    internal static async Task<string> GetPuzzleResult(int day, int part, string input)
    {
        if (day < 1 || day > _puzzles.Count)
            return $"Invalid day: {day}";

        return await ExecutePuzzle(_puzzles[day - 1], part, input);
    }

    [JSExport]
    internal static async Task<string?> GetInput(string day)
    {
        var assembly = Assembly.GetExecutingAssembly();
        using var stream = assembly.GetManifestResourceStream(day);
        if (stream is null)
            return null;

        using var reader = new StreamReader(stream);
        var input = await reader.ReadToEndAsync();
        return input.TrimEnd();
    }

    private static async Task<string> ExecutePuzzle(IPuzzle puzzle, int part, string input)
        => part switch
        {
            1 => await puzzle.Part1(input),
            2 => await puzzle.Part2(input),
            _ => $"Invalid part: {part}",
        };
}
