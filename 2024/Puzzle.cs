internal abstract class Puzzle : IPuzzle
{
    private long _previousIntermediateResult = -1;

    protected async Task SetIntermediateResult(long value)
    {
        if (value - _previousIntermediateResult > 10)
        {
            await JavascriptImports.SetIntermediateResult(value.ToString());
            _previousIntermediateResult = value;
        }
    }

    protected static Task<string> ToString(long value)
        => Task.FromResult(value.ToString());

    public abstract Task<string> Part1(string input);

    public abstract Task<string> Part2(string input);
}
