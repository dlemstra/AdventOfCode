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
    String position = "AA";
    String elephantPosition = "";
    List<String> openValves = [];

    State() {}

    State.positionNext(State other, String position) {
        this.minute = other.minute + 1;
        this.pressure = other.pressure;
        this.nextPressure = other.nextPressure;
        this.totalPressure = other.totalPressure;
        this.position = position;
        this.elephantPosition = other.elephantPosition;
        this.openValves = new List<String>.from(other.openValves);
    }

    State.elephantNext(State other, String elephantPosition) {
        this.minute = other.minute + 1;
        this.pressure = other.pressure;
        this.nextPressure = other.nextPressure;
        this.totalPressure = other.totalPressure;
        this.position = other.position;
        this.elephantPosition = elephantPosition;
        this.openValves = new List<String>.from(other.openValves);
    }

    State.next(State other, String position, String elephantPosition) {
        this.minute = other.minute + 1;
        this.pressure = other.pressure;
        this.nextPressure = other.nextPressure;
        this.totalPressure = other.totalPressure;
        this.position = position;
        this.elephantPosition = elephantPosition;
        this.openValves = new List<String>.from(other.openValves);
    }

    String get key
        => "${this.position}-${this.elephantPosition}-${this.minute}";

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

State? openValve(State state, Valve valve) {
    if (valve.rate > 0 && !state.openValves.contains(valve.name)) {
        final nextState = new State.next(state, state.position, state.elephantPosition);
        nextState.nextPressure += valve.rate;
        nextState.openValves.add(valve.name);
        return nextState;
    }

    return null;
}

void solve(List<String> lines, bool withElephants) {
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
    final firstState = new State();
    if (withElephants) {
        firstState.elephantPosition = "AA";
    }

    states.add(firstState);

    final visited = new Map();

    num maxMinutes = withElephants ? 27 : 31;
    num bestPressure = 0;
    while (states.length > 0) {
        final state = states.removeLast();
        state.incrementPressure();

        if (visited.containsKey(state.key) && state.totalPressure <= visited[state.key]) {
            continue;
        }

        visited[state.key] = state.totalPressure;

        if (state.minute == maxMinutes) {
            final old = bestPressure;
            bestPressure = max(bestPressure, state.totalPressure);
            continue;
        }

        final valve = valves[state.position];

        if (state.openValves.length == valves.length) {
            states.add(new State.next(state, state.position, state.elephantPosition));
            continue;
        }

        if (withElephants) {
            final elephant = valves[state.elephantPosition];

            var nextState = openValve(state, valve);
            if (nextState != null) {
                nextState.minute--;
                final nextState2 = openValve(nextState, elephant);
                if (nextState2 != null) {
                    states.add(nextState2);
                }
                for (final exit in elephant.exits) {
                    states.add(new State.elephantNext(nextState, exit));
                }
            }

            nextState = openValve(state, elephant);
            if (nextState != null) {
                nextState.minute--;
                for (final exit in valve.exits) {
                    states.add(new State.positionNext(nextState, exit));
                }
            }

            for (final exit1 in valve.exits) {
                for (final exit2 in elephant.exits) {
                    if (exit1 != exit2) {
                        states.add(new State.next(state, exit1, exit2));
                    }
                }
            }
        } else {
            final nextState = openValve(state, valve);
            if (nextState != null) {
                states.add(nextState);
            }

            for (final exit in valve.exits) {
                states.add(new State.positionNext(state, exit));
            }
        }
    }

    print(bestPressure);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    solve(lines, false);
    solve(lines, true);
}
