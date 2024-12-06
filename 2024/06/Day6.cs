internal class Day6 : IPuzzle
{
    public string Part1(string input)
    {
        var (map, startX, startY) = LoadMap(input);
        var direction = Direction.North;

        var visited = new HashSet<string>();
        while (startX >= 0 && startX < map[0].Length && startY >= 0 && startY < map.Length)
        {
            if (map[startY][startX] == '#')
            {
                switch (direction)
                {
                    case Direction.North:
                        startY++;
                        break;
                    case Direction.East:
                        startX--;
                        break;
                    case Direction.South:
                        startY--;
                        break;
                    case Direction.West:
                        startX++;
                        break;
                }
                direction = (Direction)(((int)direction + 1) % 4);
            }

            visited.Add($"{startX},{startY}");

            switch (direction)
            {
                case Direction.North:
                    startY--;
                    break;
                case Direction.East:
                    startX++;
                    break;
                case Direction.South:
                    startY++;
                    break;
                case Direction.West:
                    startX--;
                    break;
            }
        }

        return visited.Count.ToString();
    }

    public string Part2(string input)
    {
        return "Not implemented";
    }

    private (char[][], int startX, int startY) LoadMap(string input)
    {
        var lines = input.Split('\n');
        var grid = new char[lines.Length][];

        var y = 0;
        var startX = -1;
        var startY = -1;
        foreach (var line in lines)
        {
            grid[y] = line.Trim().ToCharArray();
            if (startY == -1)
            {
                startX = Array.IndexOf(grid[y], '^');
                if (startX != -1)
                    startY = y;
            }
            y++;
        }

        return (grid, startX, startY);
    }

    enum Direction
    {
        North,
        East,
        South,
        West
    }
}
