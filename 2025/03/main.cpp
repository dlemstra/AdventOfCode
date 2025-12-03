#include <fstream>
#include <iostream>

int main() {
    std::ifstream file("input");
    std::string line;

    long part1 = 0;
    while (std::getline(file, line))
    {
        int best = 0;
        for (auto i = 0; i <  line.length(); i++)
        {
            for (auto j = line.length() - 1; j > i; j--)
            {
                int value = ((line[i] - '0') * 10) + (line[j] - '0');
                if (value > best)
                    best = value;
            }
        }
        part1 += best;
    }

    std::cout << part1 << std::endl;

    return 0;
}
