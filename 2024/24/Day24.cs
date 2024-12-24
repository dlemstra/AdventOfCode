using System.Text;

internal sealed class Day24 : Puzzle
{
    public override Task<string> Part1(string input)
    {
        var lines = input.Split("\n").Select(l => l.Trim()).ToArray();

        var i = 0;
        var values = new Dictionary<string, int>();
        while (i < lines.Length)
        {
            var info = lines[i].Split(": ");
            if (info.Length != 2)
                break;

            values[info[0]] = int.Parse(info[1]);

            i++;
        }

        i++;
        var gates = new Dictionary<string, Gate>();
        while (i < lines.Length)
        {
            var info = lines[i].Split(" ");
            if (info.Length != 5)
                break;

            var operation = info[1];

            if (gates.TryGetValue(info[4], out var gate))
                gate.Operation = operation;
            else
                gate = gates[info[4]] = new(info[4], operation);

            if (!gates.TryGetValue(info[0], out var left))
                left = gates[info[0]] = new(info[0]);

            gate.Left = left;

            if (!gates.TryGetValue(info[2], out var right))
                right = gates[info[2]] = new(info[2]);

            gate.Right = right;

            i++;
        }

        foreach (var kv in values)
        {
            gates[kv.Key].SetValue(kv.Value);
        }

        var result = 0L;
        var bitPosition = 0;
        foreach (var gate in gates.Where(kv => kv.Key.StartsWith('z')).OrderBy(kv => kv.Key).Select(kv => kv.Value))
        {
            var value = gate.GetValue();
            if (value == 1)
                result |= (1L << bitPosition);

            bitPosition++;
        }

        return ToString(result);
    }

    public override Task<string> Part2(string input)
    {
        return Task.FromResult("Not implemented");
    }

    private class Gate
    {
        private int? _value;

        public Gate(string name, string? operation = null)
        {
            Name = name;
            Operation = operation;
        }

        public string Name { get; }
        public Gate? Left { get; set; }
        public Gate? Right { get; set; }
        public string? Operation { get; set; }

        public int GetValue()
        {
            if (_value == null)
            {
                var left = Left!.GetValue();
                var right = Right!.GetValue();
                switch (Operation)
                {
                    case "AND":
                        _value = left & right;
                        break;
                    case "OR":
                        _value = left | right;
                        break;
                    case "XOR":
                        _value = left ^ right;
                        break;
                }
            }

            return _value!.Value;
        }

        public void SetValue(int value)
            => _value = value;
    }
}
