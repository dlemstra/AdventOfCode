#include <fstream>
#include <iostream>

#include <algorithm>

long findPart2(const std::string& s) {
    std::string result;
    auto n = s.length();

    for (auto i = 0; i < n && result.length() < 12; i++)
    {
        auto remaining_needed = 12 - result.length();
        auto window_end = n - remaining_needed + 1;

        auto max_char = *std::max_element(s.begin() + i, s.begin() + window_end);

        if (s[i] == max_char)
            result += s[i];
    }

    return std::stol(result);
}

int main() {
    std::ifstream file("input");
    std::string line;

    long part1 = 0;
    long part2 = 0;
    while (std::getline(file, line))
    {
        int best = 0;
        for (auto i = 0; i <  line.length(); i++)
        {
            for (auto j = line.length() - 1; j > i; j--)
            {
                auto value = ((line[i] - '0') * 10) + (line[j] - '0');
                if (value > best)
                    best = value;
            }
        }

        part1 += best;
        part2 += findPart2(line);
    }

    std::cout << part1 << std::endl;
    std::cout << part2 << std::endl;

    return 0;
}
