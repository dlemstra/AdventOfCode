internal abstract class Puzzle : IPuzzle
{
    private long _previousIntermediateResult = 0;
    private long _delta = 0;

    protected async Task SetIntermediateResult(long value)
    {
        var delta = Math.Abs(value - _previousIntermediateResult);

        if (delta >= _delta)
        {
            await JavascriptImports.SetIntermediateResult(value.ToString());
            _delta = delta;
            _previousIntermediateResult = value;
        }
    }

    protected static Task<string> ToString(long value)
        => Task.FromResult(value.ToString());

    public abstract Task<string> Part1(string input);

    public abstract Task<string> Part2(string input);
}
