#include <fstream>
#include <iostream>

#include <vector>

class Point
{
public:
    Point(long x, long y) : x(x), y(y) {}
    long x;
    long y;
};

int main()
{
    std::ifstream file("input");
    std::string line;

    long part1 = 0;
    std::vector<Point> points;
    while (std::getline(file, line))
    {
        auto offset = line.find(',');
        auto x = std::stol(line.substr(0, offset));
        auto y = std::stol(line.substr(offset + 1));
        points.emplace_back(x, y);
    }

    for (auto i = 0; i < points.size(); i++)
    {
        for (auto j = i + 1; j < points.size(); j++)
        {
            auto dx = std::abs(points[i].x - points[j].x) + 1;
            auto dy = std::abs(points[i].y - points[j].y) + 1;
            auto size = dx * dy;
            if (size > part1)
                part1 = size;
        }
    }

    std::cout << "Part 1: " << part1 << std::endl;

    return 0;
}
