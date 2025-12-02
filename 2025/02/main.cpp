#include <fstream>
#include <iostream>

#include <sstream>
#include <vector>
#include <string>

std::vector<std::string> split(const std::string& s, char delimiter = '-')
 {
    std::vector<std::string> parts;
    std::stringstream ss(s);
    std::string item;
    while (std::getline(ss, item, delimiter)) {
        parts.push_back(item);
    }
    return parts;
}

int main() {
    std::ifstream file("input");
    std::string line;

    long part1 = 0;
    while (std::getline(file, line))
    {
        auto ranges = split(line, ',');
        for (const auto& item : ranges) {
            auto ids = split(item, '-');
            auto start = std::stol(ids[0]);
            auto end = std::stol(ids[1]);
            for (auto i = start; i <= end; ++i)
            {
                auto value = std::to_string(i);
                if (value.length() % 2 == 0)
                {
                    auto len = value.length() / 2;
                    if (value.substr(0,len) == value.substr(len,len))
                        part1 += i;
                }
            }
        }
    }

    std::cout << part1 << std::endl;

    return 0;
}
