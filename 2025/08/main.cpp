#include <fstream>
#include <iostream>

#include <vector>
#include <cmath>
#include <algorithm>
#include <tuple>
#include <unordered_set>

class Box
{
public:
    Box(int id, int x, int y, int z)
        : id(id), _x(x), _y(y), _z(z)
    {
    }

    const int id;

    double distanceTo(const Box& other) const
    {
        long dx = _x - other._x;
        long dy = _y - other._y;
        long dz = _z - other._z;
        return std::sqrt(dx * dx + dy * dy + dz * dz);
    }

private:
    int _x;
    int _y;
    int _z;
};

class Circuit
{
public:
    Circuit(const Box& left, const Box& right)
    {
        _connectedBoxes.insert(left.id);
        _connectedBoxes.insert(right.id);
    }

    bool connect(const Box& left, const Box& right)
    {
        auto containsLeft = _connectedBoxes.find(left.id) != _connectedBoxes.end();
        auto containsRight = _connectedBoxes.find(right.id) != _connectedBoxes.end();

        if (!containsLeft && !containsRight)
            return false;

        if (containsLeft && containsRight)
            return true;

        if (!containsLeft)
            _connectedBoxes.insert(left.id);
        if (!containsRight)
            _connectedBoxes.insert(right.id);

        return true;
    }

    void merge(Circuit& other)
    {
        for (const auto& boxId : _connectedBoxes)
        {
            if (other._connectedBoxes.find(boxId) != other._connectedBoxes.end())
            {
                for (const auto& otherBoxId : _connectedBoxes)
                {
                    other._connectedBoxes.insert(otherBoxId);
                }
                _connectedBoxes.clear();
                break;
            }
        }
    }

    int size() const
    {
        return _connectedBoxes.size();
    }

private:
    std::unordered_set<int> _connectedBoxes;
};

int main() {
    std::ifstream file("input");
    std::string line;

    std::vector<Box> boxes;
    auto id = 0;
    while (std::getline(file, line))
    {
        auto start = 0;
        auto end = line.find(',', start);
        auto x = std::stoi(line.substr(start, end - start));
        start = end + 1;
        end = line.find(',', start);
        auto y = std::stoi(line.substr(start, end - start));
        start = end + 1;
        auto z = std::stoi(line.substr(start));

        boxes.emplace_back(id++, x, y, z);
    }

    std::vector<std::tuple<double, int, int>> distanceConnections;
    for (auto i = 0; i < boxes.size(); i++)
    {
        for (auto j = i + 1; j < boxes.size(); j++)
        {
            auto distance = boxes[i].distanceTo(boxes[j]);
            distanceConnections.emplace_back(distance, i, j);
        }
    }

    std::sort(distanceConnections.begin(), distanceConnections.end());

    std::vector<Circuit> circuits;
    for (auto k = 0; k < 1000; k++)
    {
        auto conn = distanceConnections[k];
        auto left = boxes[std::get<1>(conn)];
        auto right = boxes[std::get<2>(conn)];

        auto connected = false;
        for (auto& circuit : circuits)
        {
            if (circuit.connect(left, right))
            {
                connected = true;
                break;
            }
        }

        if (!connected)
            circuits.emplace_back(left, right);
    }

    for (auto i = 0; i < circuits.size(); i++)
        for (auto j = i + 1; j < circuits.size(); j++)
            circuits[i].merge(circuits[j]);

    std::vector<int> sizes;
    for (auto i = 0; i < circuits.size(); i++)
        sizes.push_back(circuits[i].size());

    std::sort(sizes.begin(), sizes.end(), std::greater<int>());

    long part1 = 1;
    for (auto i = 0; i < 3; i++)
        part1 *= sizes[i];

    std::cout << "Part 1: " << part1 << std::endl;

    return 0;
}
