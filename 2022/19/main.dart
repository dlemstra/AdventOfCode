import 'dart:io';
import 'dart:math';

class Blueprint {
    int oreOreCosts = 0;
    int clayOreCosts = 0;
    int obsidianOreCosts = 0;
    int obsidianClayCosts = 0;
    int geodeOreCosts = 0;
    int geodeObsidianCosts = 0;

    Blueprint(this.oreOreCosts, this.clayOreCosts, this.obsidianOreCosts, this.obsidianClayCosts, this.geodeOreCosts, this.geodeObsidianCosts);
}

class MineralState {
    int minute = 1;
    int oreCount = 1;
    int oreTotal = 0;
    int clayCount = 0;
    int clayTotal = 0;
    int obsidianCount = 0;
    int obsidianTotal = 0;
    int geodeCount = 0;
    int geodeTotal = 0;

    increment() {
        this.minute++;
        this.oreTotal += this.oreCount;
        this.clayTotal += this.clayCount;
        this.obsidianTotal += this.obsidianCount;
        this.geodeTotal += this.geodeCount;
    }

    MineralState() {}

    MineralState.from(MineralState other) {
        this.minute = other.minute;
        this.oreCount = other.oreCount;
        this.oreTotal = other.oreTotal;
        this.clayCount = other.clayCount;
        this.clayTotal = other.clayTotal;
        this.obsidianCount = other.obsidianCount;
        this.obsidianTotal = other.obsidianTotal;
        this.geodeCount = other.geodeCount;
        this.geodeTotal = other.geodeTotal;
    }

    List<MineralState> getNextStates(Blueprint blueprint, int maxMinutes) {
        final result = <MineralState>[];
        MineralState next;
        int oresNeeded;
        int incrementCount;

        if (this.obsidianCount > 0) {
            next = MineralState.from(this);
            oresNeeded = max(0, blueprint.geodeOreCosts - next.oreTotal);
            var obsidianNeeded = max(0, blueprint.geodeObsidianCosts - next.obsidianTotal);
            incrementCount = oresNeeded == 0 && obsidianNeeded == 0 ? 1 : max(1, max((oresNeeded / next.oreCount).ceil() + 1, (obsidianNeeded / next.obsidianCount).ceil() + 1));
            while (incrementCount-- != 0) { next.increment(); }
            if (next.minute <= maxMinutes) {
                next.oreTotal -= blueprint.geodeOreCosts;
                next.obsidianTotal -= blueprint.geodeObsidianCosts;
                next.geodeCount++;
                result.add(next);
            }
        }

        if (this.clayCount > 0) {
            if (this.obsidianTotal <= blueprint.geodeObsidianCosts) {
                next = MineralState.from(this);
                oresNeeded = max(0, blueprint.obsidianOreCosts - next.oreTotal);
                var clayNeeded = max(0, blueprint.obsidianClayCosts - next.clayTotal);
                incrementCount = oresNeeded == 0 && clayNeeded == 0 ? 1 : max(1, max((oresNeeded / next.oreCount).ceil() + 1, (clayNeeded / next.clayCount).ceil() + 1));
                while (incrementCount-- != 0) { next.increment(); }
                if (next.minute <= maxMinutes) {
                    next.oreTotal -= blueprint.obsidianOreCosts;
                    next.clayTotal -= blueprint.obsidianClayCosts;
                    next.obsidianCount++;
                    result.add(next);
                }
            }
        }

        final maxClay = max(blueprint.obsidianClayCosts, blueprint.geodeObsidianCosts);
        if (this.oreTotal <= maxClay) {
            next = MineralState.from(this);
            oresNeeded = max(0, blueprint.clayOreCosts - next.oreTotal);
            incrementCount = oresNeeded == 0 ? 1 : (oresNeeded / next.oreCount).ceil() + 1;
            while (incrementCount-- != 0) { next.increment(); }
            if (next.minute <= maxMinutes) {
                next.oreTotal -= blueprint.clayOreCosts;
                next.clayCount++;
                result.add(next);
            }
        }

        var maxOres = max(blueprint.clayOreCosts, max(blueprint.obsidianOreCosts, blueprint.geodeOreCosts));
        if (this.oreTotal <= maxOres) {
            next = MineralState.from(this);
            oresNeeded = max(0, blueprint.oreOreCosts - next.oreTotal);
            incrementCount = oresNeeded == 0 ? 1 : (oresNeeded / next.oreCount).ceil() + 1;
            while (incrementCount-- != 0) { next.increment(); }
            if (next.minute <= maxMinutes) {
                next.oreTotal -= blueprint.oreOreCosts;
                next.oreCount++;
                result.add(next);
            }
        }

        return result;
    }

    String get key
        => "${this.oreCount}-${this.oreTotal}-${this.clayCount}-${this.clayTotal}-${this.obsidianCount}-${this.obsidianTotal}-${this.geodeCount}-${this.geodeTotal}";

    @override
    String toString()
        => "${this.minute} => ${this.oreCount}: ${this.oreTotal}|${this.clayCount}: ${this.clayTotal}|${this.obsidianCount}: ${this.obsidianTotal}|${this.geodeCount}: ${this.geodeTotal}";
}

List<Blueprint> loadBlueprints(List<String> lines) {
    final blueprints = <Blueprint>[];
    for (final line in lines) {
        final info = line.split(" ");
        final oreOreCosts = int.parse(info[6]);
        final clayOreCosts = int.parse(info[12]);
        final obsidianOreCosts = int.parse(info[18]);
        final obsidianClayCosts = int.parse(info[21]);
        final geodeOreCosts = int.parse(info[27]);
        final geodeObsidianCosts = int.parse(info[30]);
        blueprints.add(new Blueprint(oreOreCosts, clayOreCosts, obsidianOreCosts, obsidianClayCosts, geodeOreCosts, geodeObsidianCosts));
    }

    return blueprints;
}

int solve(Blueprint blueprint, int maxMinutes) {
    var maxGeodeTotal = 0;
    final visited = new Set<String>();
    final stack = <MineralState>[];
    stack.addAll(new MineralState().getNextStates(blueprint, maxMinutes));
    while (stack.length != 0) {
        final state = stack.removeLast();

        if (state.minute >= maxMinutes) {
            state.increment();
            maxGeodeTotal = max(maxGeodeTotal, state.geodeTotal);
            continue;
        }

        if (visited.add(state.key)) {
            stack.addAll(state.getNextStates(blueprint, maxMinutes));
        }
    }

    return maxGeodeTotal;
}

void part1(List<Blueprint> blueprints) {
    var part1 = 0;
    for (var i = 0; i < blueprints.length; i++) {
        part1 += (i + 1) * solve(blueprints[i], 24);
    }
    print(part1);
}

void part2(List<Blueprint> blueprints) {
    var part2 = 1;
    for (var i = 0; i < 3; i++) {
        part2 *= solve(blueprints[i], 32);
    }
    print(part2);
}

void main() {
    final input = new File("input");
    final lines = input.readAsLinesSync();

    final blueprints = loadBlueprints(lines);

    part1(blueprints);
    part2(blueprints);
}
