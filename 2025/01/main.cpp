#include <iostream>
#include <fstream>
#include <string>

int main() {
    std::ifstream file("input");
    std::string line;

    ssize_t value = 50;
    size_t count = 0;
    while (std::getline(file, line)) {
        int num = std::stoi(line.substr(1));
        if (line[0] == 'L')
            value -= num;
        else if (line[0] == 'R')
            value += num;

        value = (value + 100) % 100;
        if (value == 0)
            count++;
    }

    std::cout << count << std::endl;

    return 0;
}
