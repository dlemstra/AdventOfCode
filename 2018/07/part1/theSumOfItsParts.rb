class Step
    def initialize(name)
        @name = name
        @dependencies = 0
        @nextSteps = []
    end
    attr_reader :name, :dependencies
    attr_writer :dependencies

    def nextSteps
        return @nextSteps
    end

    def addNext(step)
        @nextSteps.push(step)
    end

    def instructions
        result = @name

        step = @nextSteps.sort_by{|step| step.name}.first

        while !step.nil?
            result += step.name

            @nextSteps.delete(step)
            step.nextSteps.each do |nextStep|
                nextStep.dependencies -= 1
                if nextStep.dependencies == 0
                    @nextSteps.push(nextStep)
                end
            end

            step = @nextSteps.sort_by{|step| step.name}.first
        end

        return result
    end

    def to_s
        return "#{name}"
    end
end

def getStep(steps, name)
    if !steps[name].nil?
        return steps[name]
    end

    step = Step.new(name)
    steps[name] = step
    return step
end

def theSumOfItsParts(input)
    steps = {}
    input.each do |line|
        info = line.split
        step1 = getStep(steps, info[1])
        step2 = getStep(steps, info[7])
        step1.addNext(step2)
        step2.dependencies += 1
    end

    noDependencies = steps.select{|key, value| value.dependencies == 0}.values

    first = nil
    if noDependencies.length == 1
        first = noDependencies[0]
    else
        first = Step.new("")
        noDependencies.each do |step|
            first.addNext(step)
            step.dependencies = 1
        end
    end

    return first.instructions
end