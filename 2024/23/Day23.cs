using System.Text;

internal sealed class Day23 : Puzzle
{
    public override Task<string> Part1(string input)
    {
        var connections = LoadConnections(input);

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
        var connections = new List<List<string>>();
        foreach (var (name, connection) in LoadConnections(input))
        {
            var items = new List<string>(connection);
            items.Add(name);

            connections.Add(items);
        }

        var best = "";
        for (var i = 0; i < connections.Count; i++)
        {
            var list = new List<string>(connections[i]);

            var possible = new Dictionary<string, int>();
            for (var j = 0; j < connections.Count; j++)
            {
                if (i == j)
                    continue;

                var uniqueItems = connections[i].Intersect(connections[j]).ToList();
                if (uniqueItems.Count * 3 < best.Length + 1)
                    continue;

                uniqueItems.Sort();
                var key = string.Join(",", uniqueItems);
                if (key.Length < best.Length)
                    continue;

                possible.TryGetValue(key, out var count);
                count++;
                possible[key] = count;
            }

            foreach (var (pass, count) in possible)
            {
                if (pass.Length > best.Length && count * 3 == pass.Length - 2)
                    best = pass;
            }
        }

        return Task.FromResult(best);
    }

    private static IReadOnlyDictionary<string, List<string>> LoadConnections(string input)
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

        return connections;
    }
}
