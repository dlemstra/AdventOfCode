#include <fstream>
#include <iostream>

#include <vector>
#include <algorithm>

class Point
{
public:
    Point(long x, long y) : x(x), y(y) {}

    const long x;
    const long y;

    long rectangleSize(const Point& other) const
    {
        auto dx = std::abs(x - other.x);
        auto dy = std::abs(y - other.y);
        return (dx + 1) * (dy + 1);
    }
};

static int sign(long val)
{
    return (val > 0) - (val < 0);
}

static long cross(long x1, long y1, long x2, long y2)
{
    return x1 * y2 - y1 * x2;
}

static bool doSegmentsCross(const Point& p1, const Point& p2, const Point& p3, const Point& p4)
{
    long d1 = sign(cross(p3.x - p1.x, p3.y - p1.y, p2.x - p1.x, p2.y - p1.y));
    long d2 = sign(cross(p4.x - p1.x, p4.y - p1.y, p2.x - p1.x, p2.y - p1.y));
    long d3 = sign(cross(p1.x - p3.x, p1.y - p3.y, p4.x - p3.x, p4.y - p3.y));
    long d4 = sign(cross(p2.x - p3.x, p2.y - p3.y, p4.x - p3.x, p4.y - p3.y));

    if (((d1 > 0 && d2 < 0) || (d1 < 0 && d2 > 0)) &&
        ((d3 > 0 && d4 < 0) || (d3 < 0 && d4 > 0)))
        return true;

    return false;
}

static bool isPointInsidePolygon(const std::vector<Point>& polygonPoints, const Point& point)
{
    auto crossings = 0;
    auto size = polygonPoints.size();

    for (int i = 0; i < size; i++)
    {
        const auto& p1 = polygonPoints[i];
        const auto& p2 = polygonPoints[(i + 1) % size];

        if (((p1.y <= point.y && point.y < p2.y) || (p2.y <= point.y && point.y < p1.y)))
        {
            auto intersectX = p1.x + (double)(point.y - p1.y) * (p2.x - p1.x) / (p2.y - p1.y);
            if (point.x < intersectX)
                crossings++;
        }
    }

    return (crossings % 2) == 1;
}

static bool isWholeRectangleInsidePolygon(std::vector<Point>& polygonPoints, const Point& topLeft, const Point& bottomRight)
{
    Point topRight(bottomRight.x, topLeft.y);
    Point bottomLeft(topLeft.x, bottomRight.y);

    if (!isPointInsidePolygon(polygonPoints, topLeft) ||
        !isPointInsidePolygon(polygonPoints, topRight) ||
        !isPointInsidePolygon(polygonPoints, bottomLeft) ||
        !isPointInsidePolygon(polygonPoints, bottomRight))
        return false;

    auto size = polygonPoints.size();
    for (int i = 0; i < size; i++)
    {
        const Point& polyP1 = polygonPoints[i];
        const Point& polyP2 = polygonPoints[(i + 1) % size];

        if (doSegmentsCross(polyP1, polyP2, topLeft, topRight) ||
            doSegmentsCross(polyP1, polyP2, topRight, bottomRight) ||
            doSegmentsCross(polyP1, polyP2, bottomRight, bottomLeft) ||
            doSegmentsCross(polyP1, polyP2, bottomLeft, topLeft))
            return false;
    }

    return true;
}

int main()
{
    std::ifstream file("input");
    std::string line;

    auto part1 = 0L;
    auto part2 = 0L;
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
            auto size = points[i].rectangleSize(points[j]);
            if (size > part1)
                part1 = size;

            if (size > part2)
            {
                Point topLeft(std::min(points[i].x, points[j].x), std::min(points[i].y, points[j].y));
                Point bottomRight(std::max(points[i].x, points[j].x), std::max(points[i].y, points[j].y));
                if (isWholeRectangleInsidePolygon(points,topLeft, bottomRight))
                {
                    if (size > part2)
                        part2 = size;
                }
            }
        }
    }

    std::cout << "Part 1: " << part1 << std::endl;
    std::cout << "Part 2: " << part2 << std::endl;

    return 0;
}
