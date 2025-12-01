#include <fstream>
#include <iostream>

int main() {
    std::ifstream file("input");
    std::string line;

    int value = 50;
    int part1 = 0;
    int part2 = 0;
    while (std::getline(file, line))
    {
        int rotations = std::stoi(line.substr(1));
        while (rotations >= 100)
        {
            rotations -= 100;
            part2++;
        }

        int oldValue = value;
        if (line[0] == 'L')
            value -= rotations;
        else if (line[0] == 'R')
            value += rotations;

        if ((oldValue != 0 && value <= 0) || value >= 100)
            part2++;

        value = (value + 100) % 100;

        if (value == 0)
            part1++;
    }

    std::cout << part1 << std::endl;
    std::cout << part2 << std::endl;

    return 0;
}
