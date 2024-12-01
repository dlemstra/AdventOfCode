let adventOfCode = {};

function initializeInput(name) {
    var input = document.getElementById(name);

    var storedValue = localStorage.getItem(name);
    if (storedValue !== null)
        input.value = storedValue;

    input.addEventListener('input', () => {
        localStorage.setItem(name, input.value);
    });

    return input;
}

(async () => {
    const { dotnet } = await import('./_framework/dotnet.js');
    const { getAssemblyExports, getConfig } = await dotnet.create();

    const mainAssemblyName = getConfig().mainAssemblyName;
    const assemblyExports  = await getAssemblyExports(mainAssemblyName);
    adventOfCode.getPuzzleResult = assemblyExports.JavascriptExports.GetPuzzleResult;
})().then(() => {
    adventOfCode.day = initializeInput('day');
    adventOfCode.part = initializeInput('part');
    adventOfCode.input = initializeInput('input');
    adventOfCode.result = document.getElementById('result');

    document.getElementById('getResult').disabled = false;
});

function getPuzzleResult() {
    const day = parseInt(adventOfCode.day.value);
    const part = parseInt(adventOfCode.part.value);
    const input = adventOfCode.input.value;

    adventOfCode.result.innerText = adventOfCode.getPuzzleResult(day, part, input);
}
