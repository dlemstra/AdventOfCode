#include <fstream>
#include <iostream>

#include <vector>
#include <map>

static long countTimelines(const std::vector<std::vector<char>>& grid, int x, int y, std::map<std::pair<int, int>, long>& cache)
{
    if (y >= grid.size())
        return 1;

    auto key = std::make_pair(x, y);
    if (cache.find(key) != cache.end())
        return cache[key];

    auto count = 0L;
    auto value = grid[y][x];

    if (value == '|' || value== 'S')
        count = countTimelines(grid, x, y + 1, cache);
    else if (value == '^')
    {
        if (x > 0)
            count = countTimelines(grid, x - 1, y + 1, cache);
        if (x < grid[y].size() - 1)
            count += countTimelines(grid, x + 1, y + 1, cache);
    }

    cache[key] = count;
    return count;
}

int main() {
    std::ifstream file("input");
    std::string line;

    long part1 = 0;
    long part2 = 0;
    std::vector<std::vector<char>> grid;
    while (std::getline(file, line))
    {
        std::vector<char> row(line.begin(), line.end());
        grid.push_back(row);
    }

    for (auto y = 1; y < grid.size(); y++)
    {
        for (auto x = 0; x < grid[y].size(); x++)
        {
            if (grid[y - 1][x] == 'S')
                grid[y][x] = '|';
            else if (grid[y - 1][x] == '|')
            {
                if (grid[y][x] == '^')
                {
                    if (x > 0)
                        grid[y][x - 1] = '|';
                    if (x < grid[y].size() - 1)
                        grid[y][x + 1] = '|';

                    part1++;
                }
                else
                    grid[y][x] = '|';
            }
        }
    }

    std::map<std::pair<int, int>, long> cache;
    for (auto x = 0; x < grid[0].size(); x++)
        if (grid[0][x] == 'S')
            part2 = countTimelines(grid, x, 0, cache);

    std::cout << "Part 1: " << part1 << std::endl;
    std::cout << "Part 2: " << part2 << std::endl;

    return 0;
}
