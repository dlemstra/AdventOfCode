#include <fstream>
#include <iostream>

#include <vector>
#include <numeric>

enum class Operation
{
    Multiply,
    Add,
};

int main()
{
    std::ifstream file("input");
    std::string line;

    std::vector<std::string> lines;
    while (std::getline(file, line))
        lines.push_back(line);

    auto lastLine = lines.back();
    lines.pop_back();

    std::vector<Operation> operations;
    for (const auto c : lastLine)
    {
        if (c == '*')
            operations.push_back(Operation::Multiply);
        else if (c == '+')
            operations.push_back(Operation::Add);
    }

    std::vector<long> totals;
    for (auto i = 0; i < lines.size(); i++)
    {
        auto number = 0;
        std::vector<long> numbers;
        for (const auto c : lines[i])
        {
            if (c == ' ')
            {
                if (number != 0)
                {
                    numbers.push_back(number);
                    number = 0;
                }
            }
            else
            {
                number = number * 10 + (c - '0');
            }
        }
        numbers.push_back(number);

        if (i == 0)
        {
            totals = numbers;
            continue;
        }

        for (auto j = 0; j < numbers.size(); j++)
        {
            if (operations[j] == Operation::Add)
                totals[j] += numbers[j];
            else if (operations[j] == Operation::Multiply)
                totals[j] *= numbers[j];
        }
    }

    auto part1 = std::accumulate(totals.begin(), totals.end(), 0L);
    auto part2 = 0L;

    auto operatorIndex = 0;
    auto total = 0L;
    for (auto x = 0; x < lines[0].size(); x++)
    {
        auto number = 0;
        for (auto y = 0; y < lines.size(); y++)
        {
            if (lines[y][x] == ' ')
                continue;

            number = number * 10 + (lines[y][x] - '0');
        }

        if (number == 0)
        {
            part2 += total;
            total = 0;
            operatorIndex++;
            continue;
        }

        if (total == 0)
        {
            total = number;
            continue;
        }

        if (operations[operatorIndex] == Operation::Add)
            total += number;
        else if (operations[operatorIndex] == Operation::Multiply)
            total *= number;
    }
    part2 += total;

    std::cout << part1 << std::endl;
    std::cout << part2 << std::endl;

    return 0;
}
