#include <fstream>
#include <iostream>

#include <vector>
#include <sstream>
#include <unordered_set>

class Range {
public:
    Range(long start, long end) : start(start), end(end) {}

    bool intersects(long value) const
    {
        return value >= start && value <= end;
    }

    long length() const
    {
        return end - start + 1;
    }

    void removeOverlap(Range& other)
    {
        if (other.length() == 0)
            return;

        if (start >= other.start && end <= other.end)
        {
            start = 0;
            end = -1;
        }
        else if (other.start >= start && other.end <= end)
        {
            other.start = 0;
            other.end = -1;
        }
        else if (end >= other.start && end <= other.end)
        {
            end = other.start - 1;
        }
        else if (start <= other.end && start >= other.start)
        {
            start = other.end + 1;
        }
    }

private:
    long start;
    long end;
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
    long part2 = 0;
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

    for (auto i = 0; i < ranges.size() - 1; i++)
    {
        if (ranges[i].length() == 0)
            continue;

        for (auto j = i + 1; j < ranges.size(); j++)
            ranges[i].removeOverlap(ranges[j]);
    }

    for (const auto& range : ranges)
        part2 += range.length();

    std::cout << part1 << std::endl;
    std::cout << part2 << std::endl;

    return 0;
}
