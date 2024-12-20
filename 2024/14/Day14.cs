internal sealed class Day14 : Puzzle
{
    public override Task<string> Part1(string input)
    {
        var width = 101;
        var height = 103;

        var count = 100;

        var q1 = 0;
        var q2 = 0;
        var q3 = 0;
        var q4 = 0;
        var centerWidth = width / 2;
        var centerHeight = height / 2;

        var robots = LoadRobots(input);
        foreach (var robot in robots)
        {
            var x = (robot.X + (count * robot.VelocityX)) % width;
            var y = (robot.Y + (count * robot.VelocityY)) % height;
            if (x < 0) x += width;
            if (y < 0) y += height;

            if (x > centerWidth)
            {
                if (y > centerHeight)
                    q4++;
                else if (y < centerHeight)
                    q2++;
            }
            else if (x < centerWidth)
            {
                if (y > centerHeight)
                    q3++;
                else if (y < centerHeight)
                    q1++;
            }
        }

        return ToString(q1 * q2 * q3 * q4);
    }

    public override async Task<string> Part2(string input)
    {
        var width = 101;
        var height = 103;

        var robots = LoadRobots(input);

        var count = 0;
        while (count++ < 10000)
        {
            HashSet<(long, long)> points = new();

            var foundTree = true;
            foreach (var robot in robots)
            {
                var x = (robot.X + (count * robot.VelocityX)) % width;
                var y = (robot.Y + (count * robot.VelocityY)) % height;
                if (x < 0) x += width;
                if (y < 0) y += height;

                if (!points.Add((x, y)))
                {
                    foundTree = false;
                    break;
                }
            }

            if (foundTree)
                break;

            await SetIntermediateResult(count);
        }

        return count.ToString();
    }

    private IReadOnlyList<Robot> LoadRobots(string input)
    {
        var robots = new List<Robot>();

        foreach (var item in input.Split('\n'))
        {
            var info = item.Split(',');

            var x = int.Parse(info[0].Split('=')[1]);
            var y = int.Parse(info[1].Split(' ')[0]);

            var vX = int.Parse(info[1].Split('=')[1]);
            var vY = int.Parse(info[2]);

            robots.Add(new(x, y, vX, vY));
        }

        return robots;
    }

    private record Robot
    {
        public Robot(int x, int y, int velocityX, int velocityY)
        {
            X = x;
            Y = y;
            VelocityX = velocityX;
            VelocityY = velocityY;
        }

        public int X { get; set; }
        public int Y { get; set; }
        public int VelocityX { get; set; }
        public int VelocityY { get; set; }
    }
}
