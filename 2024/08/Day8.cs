internal class Day8 : IPuzzle
{
    public string Part1(string input)
    {
        var (antennaLists, x, y) = ReadInput(input);

        var antinodes = new HashSet<(int, int)>();
        foreach (var antennas in antennaLists.Values)
        {
            for (var i = 0; i < antennas.Count; i++)
            {
                var (x1, y1) = antennas[i];
                for (var j = i + 1; j < antennas.Count; j++)
                {
                    var (x2, y2) = antennas[j];

                    var diffX = x2 - x1;
                    var diffY = y2 - y1;

                    var antiNodeX = x1 - diffX;
                    var antiNodeY = y1 - diffY;
                    if (antiNodeX >= 0 && antiNodeX <= x && antiNodeY >= 0 && antiNodeY <= y)
                        antinodes.Add((antiNodeX, antiNodeY));

                    antiNodeX = x2 + diffX;
                    antiNodeY = y2 + diffY;
                    if (antiNodeX >= 0 && antiNodeX <= x && antiNodeY >= 0 && antiNodeY <= y)
                        antinodes.Add((antiNodeX, antiNodeY));
                }
            }
        }

        return antinodes.Count.ToString();
    }

    public string Part2(string input)
    {
        var (antennaLists, x, y) = ReadInput(input);

        var antinodes = new HashSet<(int, int)>();
        foreach (var antennas in antennaLists.Values)
        {
            for (var i = 0; i < antennas.Count; i++)
            {
                var (x1, y1) = antennas[i];
                antinodes.Add((x1, y1));
                for (var j = i + 1; j < antennas.Count; j++)
                {
                    var (x2, y2) = antennas[j];
                    antinodes.Add((x2, y2));

                    var diffX = x2 - x1;
                    var diffY = y2 - y1;

                    var antiNodeX = x1 - diffX;
                    var antiNodeY = y1 - diffY;
                    while (antiNodeX >= 0 && antiNodeX <= x && antiNodeY >= 0 && antiNodeY <= y)
                    {
                        antinodes.Add((antiNodeX, antiNodeY));
                        antiNodeX -= diffX;
                        antiNodeY -= diffY;
                    }

                    antiNodeX = x2 + diffX;
                    antiNodeY = y2 + diffY;
                    while (antiNodeX >= 0 && antiNodeX <= x && antiNodeY >= 0 && antiNodeY <= y)
                    {
                        antinodes.Add((antiNodeX, antiNodeY));
                        antiNodeX += diffX;
                        antiNodeY += diffY;
                    }
                }
            }
        }

        return antinodes.Count.ToString();
    }

    private static (Dictionary<char, List<(int, int)>>, int, int) ReadInput(string input)
    {
        var antennaLists = new Dictionary<char, List<(int, int)>>();

        var x = 0;
        var y = 0;
        foreach (var line in input.Split('\n'))
        {
            x = -1;
            foreach (var character in line)
            {
                x++;
                if (character == '.' || character == '\r' || character == '\n')
                    continue;

                if (!antennaLists.ContainsKey(character))
                    antennaLists[character] = new();

                antennaLists[character].Add((x, y));
            }
            y++;
        }

        y--;

        return (antennaLists, x, y);
    }
}
