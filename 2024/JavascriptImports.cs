using System.Runtime.InteropServices.JavaScript;

public partial class JavascriptImports
{
    [JSImport("globalThis.setResult")]
    internal static partial void SetResult(string result);


    [JSImport("globalThis.setIntermediateResult")]
    internal static partial Task SetIntermediateResult(string result);
}
