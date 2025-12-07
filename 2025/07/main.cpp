#include <fstream>
#include <iostream>

#include <vector>

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

    std::cout << part1 << std::endl;

    return 0;
}
