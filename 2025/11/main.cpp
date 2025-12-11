#include <fstream>
#include <iostream>

#include <vector>
#include <unordered_map>
#include <deque>

class ServerRack
{
public:
    ServerRack() = default;

    ServerRack(std::string name)
        : name(name)
    {
    }

    std::string name;
    std::vector<std::string> connections;
};

int main()
{
    std::ifstream file("input");
    std::string line;

    long part1 = 0;
    std::unordered_map<std::string, ServerRack> racks;
    while (std::getline(file, line))
    {
        auto end = line.find(':');
        auto name = line.substr(0, end);
        racks[name] = ServerRack(name);

        auto start = end + 2;
        end = line.find(' ', start);
        while (end != std::string::npos)
        {
            racks[name].connections.push_back(line.substr(start, end - start));
            start = end + 1;
            end = line.find(' ', start);
        }
        racks[name].connections.push_back(line.substr(start));
    }

    std::deque<std::string> namesToVisit;
    namesToVisit.push_back("you");
    while (!namesToVisit.empty())
    {
        auto name = namesToVisit.front();
        namesToVisit.pop_front();
        if (name == "out")
        {
            part1++;
            continue;
        }

        auto& currentRack = racks[name];
        for (const auto& connName : currentRack.connections)
            namesToVisit.push_back(connName);
    }


    std::cout << "Part 1: " << part1 << std::endl;

    return 0;
}
