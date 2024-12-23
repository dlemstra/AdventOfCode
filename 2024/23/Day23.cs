using System.Text;

internal sealed class Day23 : Puzzle
{
    public override Task<string> Part1(string input)
    {
        var connections = new Dictionary<string, List<string>>();
        foreach (var line in input.Split("\n"))
        {
            var info = line.Trim().Split('-');
            if (info.Length != 2)
                continue;

            var left = info[0];
            var right = info[1];

            if (!connections.TryGetValue(left, out var leftList))
                leftList = [];
            leftList.Add(right);
            connections[left] = leftList;

            if (!connections.TryGetValue(right, out var rightList))
                rightList = [];
            rightList.Add(left);
            connections[right] = rightList;
        }

        var possible = new HashSet<string>();
        foreach (var connection in connections.Keys)
        {
            if (!connection.StartsWith("t"))
                continue;

            foreach (var other1 in connections[connection])
            {
                foreach (var other2 in connections[other1])
                {
                    if (!connections[other2].Contains(connection))
                        continue;

                    var name = new List<string>([connection, other1, other2]);
                    name.Sort();
                    possible.Add(string.Join(',', name));
                }
            }
        }

        return ToString(possible.Count);
    }

    public override Task<string> Part2(string input)
    {
        return Task.FromResult("Not implemented");
    }
}
