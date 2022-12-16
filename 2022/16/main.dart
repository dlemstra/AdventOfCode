import 'dart:io';
import 'dart:math';

class Valve {
    String name = "";
    num rate = 0;
    List<String> exits = <String>[];

    Valve(String name, int rate) {
        this.name = name;
        this.rate = rate;
    }
}

class State {
    num minute = 1;
    num pressure = 0;
    num nextPressure = 0;
    num totalPressure = 0;
    String valveName = "AA";
    List<String> openValves = [];

    State() {}

    State.next(State other, String valveName) {
        this.minute = other.minute + 1;
        this.pressure = other.pressure;
        this.totalPressure = other.totalPressure;
        this.valveName = valveName;
        this.openValves = new List<String>.from(other.openValves);
    }

    String get key
        => "${this.valveName}-${this.pressure}-${this.minute}";

    void incrementPressure() {
        if (this.nextPressure == 0) {
            this.totalPressure += this.pressure;
        } else {
            this.totalPressure += this.pressure;
            this.pressure += this.nextPressure;
            this.nextPressure = 0;
        }
    }

    @override
    String toString()
        => "${this.key} => ${this.pressure} ${this.totalPressure}";
}

void solve(List<String> lines) {
    final valves = new Map();
    for (final line in lines) {
        final info = line.split(" ");
        final valve = new Valve(info[1], int.parse(info[4].replaceAll(";", "").split("=")[1]));
        for (var i=9; i < info.length; i++) {
            valve.exits.add(info[i].replaceAll(",", ""));
        }
        valves[valve.name] = valve;
    }

    final states = <State>[];
    states.add(new State());

    final visited = new Map();

    num part1 = 0;
    while(states.length > 0) {
        final state = states.removeLast();
        state.incrementPressure();

        if (state.minute == 31) {
            part1 = max(part1, state.totalPressure);
            continue;
        }

        if (visited.containsKey(state.key) && state.totalPressure <= visited[state.key]) {
            continue;
        }

        visited[state.key] = state.totalPressure;

        if (state.openValves.length == valves.length) {
            states.add(new State.next(state, state.valveName));
            continue;
        }

        final valve = valves[state.valveName];

        if (valve.rate > 0 && !state.openValves.contains(valve.name)) {
            final nextState = new State.next(state, valve.name);
            nextState.nextPressure = valve.rate;
            nextState.openValves.add(valve.name);
            states.add(nextState);
        }

        for (final exit in valve.exits) {
            states.add(new State.next(state, exit));
        }
    }

    print(part1);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines);
}
