#include <fstream>
#include <iostream>

#include <algorithm>
#include <vector>
#include <deque>
#include <limits>
#include <unordered_set>
#include <numeric>

class Button
{
public:
    Button(const std::vector<int>& presses) : presses(presses) {}

    const std::vector<int> presses;
};

class Machine
{
public:
    Machine(const std::string& goal) : goal(goal) {}

    const std::string goal;
    std::vector<int> joltageGoal;
    std::vector<Button> buttons;

    void addButton(const std::string& buttonStr)
    {
        std::vector<int> buttonPresses;

        auto startPos = 0;
        auto commaPos = buttonStr.find(',', startPos);
        while (commaPos != std::string::npos)
        {
            buttonPresses.push_back(std::stoi(buttonStr.substr(startPos, commaPos - startPos)));
            startPos = commaPos + 1;
            commaPos = buttonStr.find(',', startPos);
        }
        buttonPresses.push_back(std::stoi(buttonStr.substr(startPos)));

        buttons.push_back(Button(buttonPresses));
    }

    void setJoltageGoal(const std::string& goalStr)
    {
        auto startPos = 0;
        auto commaPos = goalStr.find(',', startPos);
        while (commaPos != std::string::npos)
        {
            joltageGoal.push_back(std::stoi(goalStr.substr(startPos, commaPos - startPos)));
            startPos = commaPos + 1;
            commaPos = goalStr.find(',', startPos);
        }
        joltageGoal.push_back(std::stoi(goalStr.substr(startPos)));
    }
};

class State
{
public:
    State(const std::string& lights) : lights(lights) {}

    std::string lights;
    long presses = 0;

    void apply(const Button& button)
    {
        for (const auto& pressPosition : button.presses)
            lights[pressPosition + 1] = (lights[pressPosition + 1] == '#') ? '.' : '#';

        presses++;
    }
};

std::pair<std::vector<int>, std::vector<std::vector<int>>> gaussianElimination(const std::vector<std::vector<int>>& matrix)
{
    auto numRows = matrix.size();
    auto numCols = matrix[0].size() - 1;

    std::vector<int> pivotCols;
    auto currentRow = 0;

    std::vector<std::vector<int>> reducedMatrix = matrix;

    for (auto col = 0; col < numCols; ++col)
    {
        if (currentRow >= numRows)
            break;

        auto pivotRow = -1;
        for (auto row = currentRow; row < numRows; row++)
        {
            if (reducedMatrix[row][col] != 0)
            {
                pivotRow = row;
                break;
            }
        }

        if (pivotRow == -1)
            continue;

        std::swap(reducedMatrix[currentRow], reducedMatrix[pivotRow]);
        pivotCols.push_back(col);

        for (auto row = currentRow + 1; row < numRows; row++)
        {
            if (reducedMatrix[row][col] != 0)
            {
                auto currentValue = reducedMatrix[row][col];
                auto pivotValue = reducedMatrix[currentRow][col];

                for (auto colIdx = col; colIdx <= numCols; colIdx++)
                    reducedMatrix[row][colIdx] = reducedMatrix[row][colIdx] * pivotValue - reducedMatrix[currentRow][colIdx] * currentValue;
            }
        }

        currentRow++;
    }

    return {pivotCols, reducedMatrix};
}

std::pair<std::vector<int>, int> solve(const std::vector<int>& freeValues,const std::vector<int>& freeVars, const std::vector<int>& pivotCols, const std::vector<std::vector<int>>& reducedMatrix, const Machine &machine, int numButtons, int numJoltages)
{
    std::vector<int> solution(numButtons, 0);
    for (auto varIdx = 0; varIdx < freeVars.size(); ++varIdx)
        solution[freeVars[varIdx]] = varIdx < freeValues.size() ? freeValues[varIdx] : 0;

    for (int pivotIdx = pivotCols.size() - 1; pivotIdx >= 0; --pivotIdx)
    {
        auto row = pivotIdx;
        auto col = pivotCols[pivotIdx];
        auto rightHandSide = reducedMatrix[row][numButtons];

        for (auto buttonIdx = col + 1; buttonIdx < numButtons; ++buttonIdx)
            rightHandSide -= reducedMatrix[row][buttonIdx] * solution[buttonIdx];

        if (reducedMatrix[row][col] == 0)
            return {{}, -1};

        if (rightHandSide % reducedMatrix[row][col] != 0)
            return {{}, -1};

        auto value = rightHandSide / reducedMatrix[row][col];
        if (value < 0)
            return {{}, -1};

        solution[col] = value;
    }

    for (auto joltageIdx = 0; joltageIdx < numJoltages; ++joltageIdx)
    {
        auto actualJoltage = 0;
        for (auto buttonIdx = 0; buttonIdx < numButtons; ++buttonIdx)
        {
            if (solution[buttonIdx] <= 0)
                continue;

            for (auto pressPosition : machine.buttons[buttonIdx].presses)
            {
                if (pressPosition == joltageIdx)
                {
                    actualJoltage += solution[buttonIdx];
                    break;
                }
            }
        }

        if (actualJoltage != machine.joltageGoal[joltageIdx])
            return {{}, -1};
    }

    auto totalPresses = 0;
    for (auto pressCount : solution)
        totalPresses += pressCount;

    return {solution, totalPresses};
}

int solveMachine(const Machine& machine)
{
    auto numJoltages = machine.joltageGoal.size();
    auto numButtons = machine.buttons.size();
    std::vector<std::vector<int>> matrix(numJoltages, std::vector<int>(numButtons + 1, 0));
    for (auto joltageIdx = 0; joltageIdx < numJoltages; joltageIdx++)
    {
        for (auto buttonIdx = 0; buttonIdx < numButtons; buttonIdx++)
        {
            auto buttonAffectsJoltage = false;
            for (auto pressPosition : machine.buttons[buttonIdx].presses)
            {
                if (pressPosition == joltageIdx)
                {
                    buttonAffectsJoltage = true;
                    break;
                }
            }

            if (buttonAffectsJoltage)
                matrix[joltageIdx][buttonIdx] = 1;
        }

        matrix[joltageIdx][numButtons] = machine.joltageGoal[joltageIdx];
    }

    auto eliminationResult = gaussianElimination(matrix);
    auto& pivotCols = eliminationResult.first;
    auto& reducedMatrix = eliminationResult.second;

    std::vector<bool> isPivotColumn(numButtons, false);
    for (auto col : pivotCols)
        isPivotColumn[col] = true;

    std::vector<int> freeVariables;
    for (auto buttonIdx = 0; buttonIdx < numButtons; ++buttonIdx)
        if (!isPivotColumn[buttonIdx])
            freeVariables.push_back(buttonIdx);

    std::vector<int> bestSolution(numButtons, 0);
    auto minPresses = -1;

    if (freeVariables.empty())
    {
        auto [solution, totalPresses] = solve({}, freeVariables, pivotCols, reducedMatrix, machine, numButtons, numJoltages);
        if (totalPresses != -1)
        {
            bestSolution = solution;
            minPresses = totalPresses;
        }
    }
    else if (freeVariables.size() == 1)
    {
        auto maxValue = *std::max_element(machine.joltageGoal.begin(), machine.joltageGoal.end()) * 3;
        for (auto freeVal = 0; freeVal <= maxValue; ++freeVal)
        {
            if (minPresses != -1 && freeVal > minPresses)
                break;

            auto [solution, totalPresses] = solve({freeVal}, freeVariables, pivotCols, reducedMatrix, machine, numButtons, numJoltages);
            if (totalPresses != -1 && (minPresses == -1 || totalPresses < minPresses))
            {
                bestSolution = solution;
                minPresses = totalPresses;
            }
        }
    }
    else if (freeVariables.size() == 2)
    {
        auto maxValue = std::max(200, *std::max_element(machine.joltageGoal.begin(), machine.joltageGoal.end()));
        for (auto freeVal1 = 0; freeVal1 <= maxValue; ++freeVal1)
        {
            for (auto freeVal2 = 0; freeVal2 <= maxValue; ++freeVal2)
             {
                if (minPresses != -1 && freeVal1 + freeVal2 > minPresses)
                 continue;

                auto [solution, totalPresses] = solve({freeVal1, freeVal2}, freeVariables, pivotCols, reducedMatrix, machine, numButtons, numJoltages);
                if (totalPresses != -1 && (minPresses == -1 || totalPresses < minPresses))
                {
                    bestSolution = solution;
                    minPresses = totalPresses;
                }
            }
        }
    }
    else if (freeVariables.size() == 3)
    {
        for (auto freeVal1 = 0; freeVal1 < 250; ++freeVal1)
        {
            for (auto freeVal2 = 0; freeVal2 < 250; ++freeVal2)
            {
                for (auto freeVal3 = 0; freeVal3 < 250; ++freeVal3)
                {
                    if (minPresses != -1 && freeVal1 + freeVal2 + freeVal3 > minPresses)
                        continue;

                    auto [solution, totalPresses] = solve({freeVal1, freeVal2, freeVal3}, freeVariables, pivotCols, reducedMatrix, machine, numButtons, numJoltages);
                    if (totalPresses != -1 && (minPresses == -1 || totalPresses < minPresses))
                    {
                        bestSolution = solution;
                        minPresses = totalPresses;
                    }
                }
            }
        }
    }
    else if (freeVariables.size() == 4)
    {
        for (auto freeVal1 = 0; freeVal1 < 30; ++freeVal1)
        {
            for (auto freeVal2 = 0; freeVal2 < 30; ++freeVal2)
            {
                for (auto freeVal3 = 0; freeVal3 < 30; ++freeVal3)
                {
                    for (auto freeVal4 = 0; freeVal4 < 30; ++freeVal4)
                    {
                        if (minPresses != -1 && freeVal1 + freeVal2 + freeVal3 + freeVal4 > minPresses)
                            continue;

                        auto [solution, totalPresses] = solve({freeVal1, freeVal2, freeVal3, freeVal4}, freeVariables, pivotCols, reducedMatrix, machine, numButtons, numJoltages);
                        if (totalPresses != -1 && (minPresses == -1 || totalPresses < minPresses))
                        {
                            bestSolution = solution;
                            minPresses = totalPresses;
                        }
                    }
                }
            }
        }
    }
    else
    {
        auto [solution, totalPresses] = solve(std::vector<int>(freeVariables.size(), 0), freeVariables, pivotCols, reducedMatrix, machine, numButtons, numJoltages);
        if (totalPresses != -1)
        {
            bestSolution = solution;
            minPresses = totalPresses;
        }
    }

    return minPresses == -1 ? 0 : minPresses;
}

int main()
{
    std::ifstream inputFile("input");
    std::string line;

    long part1 = 0;
    long part2 = 0;
    std::vector<Machine> machines;
    while (std::getline(inputFile, line))
    {
        auto spacePos = line.find(' ');
        Machine machine(line.substr(0, spacePos));
        auto startPos = spacePos + 2;
        auto closeParenPos = line.find(')', startPos);
        while (closeParenPos != std::string::npos)
        {
            auto buttonStr = line.substr(startPos, closeParenPos - startPos);
            machine.addButton(buttonStr);
            startPos = closeParenPos + 3;
            closeParenPos = line.find(')', startPos);
        }
        machine.setJoltageGoal(line.substr(startPos, line.length() - 2));
        machines.push_back(machine);
    }

    for (const auto& machine : machines)
    {
        auto lights = machine.goal;
        std::replace(lights.begin(), lights.end(), '#', '.');

        std::deque<State> states;
        auto count = std::numeric_limits<long>::max();
        for (const auto& button : machine.buttons)
        {
            State state(lights);
            state.apply(button);

            states.push_back(state);
            while (!states.empty())
            {
                State current = states.front();
                states.pop_front();

                if (current.presses >= count || current.presses > 100)
                    continue;

                if (current.lights == machine.goal)
                {
                    count = std::min(count, current.presses);
                    continue;
                }

                for (const auto& nextButton : machine.buttons)
                {
                    State nextState = current;
                    nextState.apply(nextButton);
                    auto key = nextState.lights + "|" + std::to_string(nextState.presses);
                    states.push_back(nextState);
                }
            }
        }

        part1 += count;
    }

    for (const auto& machine : machines)
       part2 += solveMachine(machine);

    std::cout << "Part 1: " << part1 << std::endl;
    std::cout << "Part 2: " << part2 << std::endl;

    return 0;
}

