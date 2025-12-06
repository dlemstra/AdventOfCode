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

    std::cout << part1 << std::endl;

    return 0;
}
