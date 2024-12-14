internal sealed class Day14 : IPuzzle
{
    public string Part1(string input)
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

        foreach (var item in input.Split('\n'))
        {
            var info = item.Split(',');

            var x = int.Parse(info[0].Split('=')[1]);
            var y = int.Parse(info[1].Split(' ')[0]);

            var vX = int.Parse(info[1].Split('=')[1]);
            var vY = int.Parse(info[2]);

            x = (x + (count * vX)) % width;
            y = (y + (count * vY)) % height;

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

        return (q1 * q2 * q3 * q4).ToString();
    }

    public string Part2(string input)
    {
        return "Not implemented";
    }
}
