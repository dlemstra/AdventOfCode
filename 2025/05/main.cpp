#include <fstream>
#include <iostream>

#include <vector>
#include <sstream>

class Range {
public:
    Range(long start, long end) : start(start), end(end) {}

    bool intersects(long value) const {
        return value >= start && value <= end;
    }

private:
    const long start;
    const long end;
};

static std::vector<std::string> split(const std::string& s, char delimiter = '-')
 {
    std::vector<std::string> parts;
    std::stringstream ss(s);
    std::string item;
    while (std::getline(ss, item, delimiter))
        parts.push_back(item);
    return parts;
}

int main() {
    std::ifstream file("input");
    std::string line;

    long part1 = 0;
    std::vector<Range> ranges;
    while (std::getline(file, line))
    {
        if (line.empty())
            break;

        auto parts = split(line, '-');
        auto start = std::stol(parts[0]);
        auto end = std::stol(parts[1]);
        ranges.push_back(Range(start, end));
    }

    while (std::getline(file, line))
    {
        auto value = std::stol(line);
        for (const auto& range : ranges)
        {
            if (range.intersects(value))
            {
                part1++;
                break;
            }
        }
    }

    std::cout << part1 << std::endl;

    return 0;
}
