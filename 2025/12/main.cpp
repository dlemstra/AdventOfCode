#include <fstream>
#include <iostream>

#include <vector>
#include <functional>
#include <algorithm>

class Box
{
public:
    Box(int id) : id(id) {}

    int id;
    std::vector<std::vector<std::vector<char>>> grids;
    int area = 0;

    int calculateArea() const
    {
        int count = 0;
        for (const auto& row : grids[0])
            for (char c : row)
                if (c == '#')
                    count++;
        return count;
    }

    void addGrid(const std::vector<std::vector<char>>& newGrid)
    {
        for (const auto& existingGrid : grids)
        {
            if (existingGrid.size() != newGrid.size() || existingGrid[0].size() != newGrid[0].size())
                continue;

            auto isSame = true;
            for (auto y = 0; y < newGrid.size(); y++)
            {
                for (auto x = 0; x < newGrid[0].size(); x++)
                {
                    if (existingGrid[y][x] != newGrid[y][x])
                    {
                        isSame = false;
                        break;
                    }
                }
                if (!isSame)
                    break;
            }

            if (isSame)
                return;
        }

        grids.push_back(newGrid);
    }
};

class Area
{
public:
    Area(int width, int height)
        : width(width),
          height(height)
    {
    }

    int width;
    int height;
    std::vector<int> counts;
};

static std::vector<std::vector<char>> readGrid(std::ifstream& file)
{
    std::vector<std::vector<char>> grid;
    std::string line;
    while (std::getline(file, line))
    {
        if (line.empty())
            break;

        std::vector<char> row(line.begin(), line.end());
        grid.push_back(row);
    }

    return grid;
}

static std::vector<std::vector<char>> rotateGrid(const std::vector<std::vector<char>>& grid)
{
    std::vector<std::vector<char>> rotated;
    auto rows = grid.size();
    auto cols = grid[0].size();
    rotated.resize(cols, std::vector<char>(rows));

    for (auto y = 0; y < rows; y++)
        for (auto x = 0; x < cols; x++)
            rotated[x][rows - y - 1] = grid[y][x];

    return rotated;
}

static std::vector<std::vector<char>> flipGrid(const std::vector<std::vector<char>>& grid)
{
    std::vector<std::vector<char>> flipped = grid;
    auto rows = grid.size();
    auto cols = grid[0].size();

    for (auto y = 0; y < rows; y++)
        for (auto x = 0; x < cols; x++)
            flipped[y][cols - x - 1] = grid[y][x];

    return flipped;
}

static bool placeBoxes(const std::vector<Box>& boxes,std::vector<std::vector<bool>>& occupied,int& occupiedCount,int totalAreaAvailable,int areaHeight,int areaWidth,int boxIndex)
{
    if (boxIndex == boxes.size())
        return true;

    auto remainingBoxArea = 0;
    for (int i = boxIndex; i < boxes.size(); i++)
        remainingBoxArea += boxes[i].area;

    auto remainingAreaAvailable = totalAreaAvailable - occupiedCount;
    if (remainingBoxArea > remainingAreaAvailable)
        return false;

    const auto& box = boxes[boxIndex];

    for (const auto& grid : box.grids)
    {
        auto gridHeight = grid.size();
        auto gridWidth = grid[0].size();

        if (gridHeight > areaHeight || gridWidth > areaWidth)
            continue;

        for (auto startY = 0; startY <= areaHeight - gridHeight; startY++)
        {
            for (auto startX = 0; startX <= areaWidth - gridWidth; startX++)
            {
                auto canPlace = true;
                for (auto y = 0; y < gridHeight && canPlace; y++)
                {
                    for (auto x = 0; x < gridWidth && canPlace; x++)
                    {
                        if (grid[y][x] == '#' && occupied[startY + y][startX + x])
                            canPlace = false;
                    }
                }

                if (!canPlace)
                    continue;

                std::vector<std::pair<int, int>> markedPositions;
                for (auto y = 0; y < gridHeight; y++)
                {
                    for (auto x = 0; x < gridWidth; x++)
                    {
                        if (grid[y][x] == '#')
                        {
                            occupied[startY + y][startX + x] = true;
                            markedPositions.emplace_back(startY + y, startX + x);
                        }
                    }
                }
                occupiedCount += markedPositions.size();

                if (placeBoxes(boxes, occupied, occupiedCount, totalAreaAvailable, areaHeight, areaWidth, boxIndex + 1))
                    return true;

                occupiedCount -= markedPositions.size();
                for (const auto& [y, x] : markedPositions)
                    occupied[y][x] = false;
            }
        }
    }

    return false;
}

static bool canFitInArea(const Area& area, std::vector<Box> boxes)
{
    std::sort(boxes.begin(), boxes.end(), [](const Box& a, const Box& b) { return a.area > b.area; });

    auto totalBoxArea = 0;
    for (const auto& box : boxes)
        totalBoxArea += box.area;

    auto totalAreaAvailable = area.width * area.height;
    if (totalBoxArea > totalAreaAvailable)
        return false;

    std::vector<std::vector<bool>> occupied(area.height, std::vector<bool>(area.width, false));
    auto occupiedCount = 0;

    return placeBoxes(boxes, occupied, occupiedCount, totalAreaAvailable, area.height, area.width, 0);
}

int main()
{
    std::ifstream file("input");
    std::string line;

    auto part1 = 0L;
    std::vector<Box> boxes;
    std::vector<Area> areas;
    while (std::getline(file, line))
    {
        if (line.empty())
            continue;

        auto pos = line.find(':');
        if (pos == line.size() - 1)
        {
            auto id = std::stoi(line.substr(0, pos));
            auto box = Box(id);
            auto grid = readGrid(file);
            box.addGrid(grid);
            box.addGrid(rotateGrid(grid));
            box.addGrid(rotateGrid(box.grids.back()));
            box.addGrid(rotateGrid(box.grids.back()));
            auto flipped = flipGrid(grid);
            box.addGrid(flipped);
            box.addGrid(rotateGrid(flipped));
            box.addGrid(rotateGrid(box.grids.back()));
            box.addGrid(rotateGrid(box.grids.back()));
            box.area = box.calculateArea();
            boxes.push_back(box);
        }
        else
        {
            auto pos = line.find('x');
            auto width = std::stoi(line.substr(pos + 1));
            auto height = std::stoi(line.substr(0, pos));
            auto area = Area(width, height);
            pos = line.find(' ');
            while (pos != std::string::npos)
            {
                auto nextPos = line.find(' ', pos + 1);
                auto count = std::stoi(line.substr(pos + 1, nextPos - pos - 1));
                area.counts.push_back(count);
                pos = nextPos;
            }

            areas.emplace_back(area);
        }
    }

    for (const auto& area : areas)
    {
        std::vector<Box> fittingBoxes;
        for (auto i=0; i < area.counts.size(); i++)
        {
            auto count = area.counts[i];
            for (auto j = 0; j < count; j++)
               fittingBoxes.push_back(boxes[i]);
        }

        if (canFitInArea(area, fittingBoxes))
        {
            part1++;
            std::cout << "\r" << part1 << std::flush;
        }
    }

    std::cout << "\rPart 1: " << part1 << std::endl;

    return 0;
}
