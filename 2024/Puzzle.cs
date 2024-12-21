internal abstract class Puzzle : IPuzzle
{
    private DateTime _lastUppate = DateTime.MinValue;

    protected async Task SetIntermediateResult(long value)
    {
        if (DateTime.Now - _lastUppate < TimeSpan.FromMilliseconds(200))
            return;

        _lastUppate = DateTime.Now;
        await JavascriptImports.SetIntermediateResult(value.ToString());
    }

    protected static Task<string> ToString(long value)
        => Task.FromResult(value.ToString());

    public abstract Task<string> Part1(string input);

    public abstract Task<string> Part2(string input);
}
