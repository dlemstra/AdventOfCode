#include <fstream>
#include <iostream>

#include <vector>
#include <unordered_map>
#include <deque>

class ServerRack
{
public:
    ServerRack() = default;

    ServerRack(int id, std::string name)
        : id(id),
          name(name)
    {
    }

    int id;
    std::string name;
    std::vector<std::string> connectionNames;
    std::vector<ServerRack*> connections;
};

static void addConnections(std::unordered_map<std::string, ServerRack>& racks)
{
    for (auto& [name, rack] : racks)
        for (const auto& connName : rack.connectionNames)
            rack.connections.push_back(&racks.at(connName));
}

static long countPaths(const ServerRack* from, int to, std::unordered_map<int, long>& cache)
{
    auto cachedValue = cache.find(from->id);
    if (cachedValue != cache.end())
        return cachedValue->second;

    if (from->id == to)
        return 1;

    auto count = 0L;
    for (const auto& connRack : from->connections)
        count += countPaths(connRack, to, cache);

    cache[from->id] = count;
    return count;
}

static long countPaths(std::unordered_map<std::string, ServerRack>& racks, std::string from, std::string to)
{
    std::unordered_map<int, long> cache;
    return countPaths(&racks[from], racks[to].id, cache);
}

static long countPaths(std::unordered_map<std::string, ServerRack>& racks, std::vector<std::string> paths)
{
    auto total = 1L;
    for (auto i = 0; i < paths.size() - 1; i++)
    {
        total *= countPaths(racks, paths[i], paths[i + 1]);
        if (total == 0)
            break;
    }

    return total;
}

int main()
{
    std::ifstream file("input");
    std::string line;

    auto part1 = 0L;
    auto part2 = 0L;
    auto id = 0;
    std::unordered_map<std::string, ServerRack> racks;
    while (std::getline(file, line))
    {
        auto end = line.find(':');
        auto name = line.substr(0, end);
        racks[name] = ServerRack(id++, name);

        auto start = end + 2;
        end = line.find(' ', start);
        while (end != std::string::npos)
        {
            racks[name].connectionNames.push_back(line.substr(start, end - start));
            start = end + 1;
            end = line.find(' ', start);
        }
        racks[name].connectionNames.push_back(line.substr(start));
    }
    racks["out"] = ServerRack(id++, "out");

    addConnections(racks);

    std::unordered_map<int, long> cache;
    part1 = countPaths(racks, "you", "out");
    part2 = countPaths(racks, {"svr", "dac", "fft", "out"});
    part2 += countPaths(racks, {"svr", "fft", "dac", "out"});

    std::cout << "Part 1: " << part1 << std::endl;
    std::cout << "Part 2: " << part2 << std::endl;

    return 0;
}
