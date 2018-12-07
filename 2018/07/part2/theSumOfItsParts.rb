class Step
    def initialize(name, extraDuration)
        @name = name
        @dependencies = 0
        @nextSteps = []
        @stepsToComplete = (@name == "" ? 0 : @name.ord - 64) + extraDuration
        @initialStepsToComplete = @stepsToComplete
    end
    attr_reader :name, :dependencies, :stepsToComplete
    attr_writer :dependencies, :stepsToComplete

    def nextSteps
        return @nextSteps
    end

    def addNext(step)
        @nextSteps.push(step)
    end

    def sortKey
        return "#{@initialStepsToComplete == @stepsToComplete ? 1 : 0 }#{name}"
    end

    def totalDuration(workers)
        result = @stepsToComplete

        steps = @nextSteps.sort_by{|step| step.sortKey}
        max = [workers, steps.length].min - 1

        while steps.length > 0

            for i in 0..max
                steps[i].stepsToComplete -= 1
            end

            steps.each do |step|
                if step.stepsToComplete != 0
                    next
                end

                steps.delete(step)

                step.nextSteps.each do |nextStep|
                    nextStep.dependencies -= 1
                    if nextStep.dependencies == 0
                        steps.push(nextStep)
                    end
                end

                steps = steps.sort_by{|step| step.sortKey}
                max = [workers, steps.length].min - 1
            end

            result += 1
        end

        return result
    end

    def to_s
        return "#{name}"
    end
end

def getStep(steps, name, extraDuration)
    if !steps[name].nil?
        return steps[name]
    end
    step = Step.new(name, extraDuration)
    steps[name] = step
    return step
end

def theSumOfItsParts(input, workers, extraDuration)
    steps = {}
    input.each do |line|
        info = line.split
        step1 = getStep(steps, info[1], extraDuration)
        step2 = getStep(steps, info[7], extraDuration)
        step1.addNext(step2)
        step2.dependencies += 1
    end

    noDependencies = steps.select{|key, value| value.dependencies == 0}.values

    first = nil
    if noDependencies.length == 1
        first = noDependencies[0]
    else
        first = Step.new("", 0)
        noDependencies.each do |step|
            first.addNext(step)
            step.dependencies = 1
        end
    end

    return first.totalDuration(workers)
end