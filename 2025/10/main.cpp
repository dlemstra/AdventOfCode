#include <fstream>
#include <iostream>

#include <algorithm>
#include <vector>
#include <deque>
#include <limits>

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
    std::vector<Button> buttons;

    void addButton(const std::string& button)
    {
        std::vector<int> presses;

        auto start = 0;
        auto end = button.find(',', start);
        while (end != std::string::npos)
        {
            presses.push_back(std::stoi(button.substr(start, end - start)));
            start = end + 1;
            end = button.find(',', start);
        }
        presses.push_back(std::stoi(button.substr(start)));

        buttons.push_back(Button(presses));
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
        for (const auto& press : button.presses)
            lights[press + 1] = (lights[press + 1] == '#') ? '.' : '#';

        presses++;
    }
};

int main()
{
    std::ifstream file("input");
    std::string line;

    long part1 = 0;
    std::vector<Machine> machines;
    while (std::getline(file, line))
    {
        auto end = line.find(' ');
        Machine machine(line.substr(0, end));
        auto start = end + 2;
        end = line.find(')', start);
        while (end != std::string::npos)
        {
            auto button = line.substr(start, end - start);
            machine.addButton(button);
            start = end + 3;
            end = line.find(')', start);
        }
        machines.push_back(machine);
    }

    for (const auto& machine : machines)
    {
        std::cout << machine.goal << " => " << std::flush;

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
        std::cout << count << std::endl;

        part1 += count;
    }

    std::cout << "Part 1: " << part1 << std::endl;

    return 0;
}

