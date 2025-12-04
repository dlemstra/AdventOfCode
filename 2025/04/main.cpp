#include <fstream>
#include <iostream>

#include <vector>

static bool canBeAccessByForklift(const std::vector<std::vector<char>> grid, int x, int y)
{
    if (grid[y][x] != '@')
        return false;

    int directions[8][2] = {
        {-1, -1}, {0, -1}, {1, -1},
        {-1, 0},           {1, 0},
        {-1, 1},  {0, 1},  {1, 1}
    };

    int count = 0;
    for (auto& dir : directions)
    {
        int nx = x + dir[0];
        int ny = y + dir[1];

        if (ny < 0 || ny >= grid.size() || nx < 0 || nx >= grid[0].size())
            continue;

        if (grid[ny][nx] == '@')
            count++;
    }

    return count < 4;
}

int main() {
    std::ifstream file("input");
    std::string line;

    long part1 = 0;
    std::vector<std::vector<char>> grid;
    while (std::getline(file, line))
    {
        std::vector<char> row(line.begin(), line.end());
        grid.push_back(row);
    }

    for (auto y = 0; y < grid.size(); y++)
        for (auto x = 0; x < grid[y].size(); x++)
            if (canBeAccessByForklift(grid, x, y))
                part1++;

    std::cout << part1 << std::endl;

    return 0;
}
