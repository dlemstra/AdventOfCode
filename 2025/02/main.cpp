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
    long part2 = 0;
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
                auto len = value.length() / 2;
                if (value.length() % 2 == 0)
                {
                    if (value.substr(0,len) == value.substr(len,len))
                        part1 += i;
                }

                auto isValid = true;
                for (auto j = 1; j <= len; ++j)
                {
                    if (value.length() % j != 0)
                        continue;

                    isValid = false;
                    auto k = 0;
                    while (k + j < value.length())
                    {
                        if (value.substr(k, j) != value.substr(k + j, j))
                        {
                            isValid = true;
                            break;
                        }
                        k += j;
                    }

                    if (!isValid)
                        break;
                }

                if (!isValid)
                    part2 += i;
            }
        }
    }

    std::cout << part1 << std::endl;
    std::cout << part2 << std::endl;

    return 0;
}
