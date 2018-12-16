class Register
    def initialize(a, b, c, d)
        @state = [a, b, c, d]
        @original = [a, b, c, d]

        @instructions = [self.method(:addr), self.method(:addi),
                         self.method(:mulr), self.method(:muli),
                         self.method(:banr), self.method(:bani),
                         self.method(:borr), self.method(:bori),
                         self.method(:setr), self.method(:seti),
                         self.method(:gtir), self.method(:gtri), self.method(:gtrr),
                         self.method(:eqir), self.method(:eqri), self.method(:eqrr)]
    end
    attr_reader :state, :instructions

    def addr(a, b, c)
        @state[c] = @state[a] + @state[b]
    end

    def addi(a, b, c)
        @state[c] = @state[a] + b
    end

    def mulr(a, b, c)
        @state[c] = @state[a] * @state[b]
    end

    def muli(a, b, c)
        @state[c] = @state[a] * b
    end

    def banr(a, b, c)
        @state[c] = @state[a] & @state[b]
    end

    def bani(a, b, c)
        @state[c] = @state[a] & b
    end

    def borr(a, b, c)
        @state[c] = @state[a] | @state[b]
    end

    def bori(a, b, c)
        @state[c] = @state[a] | b
    end

    def setr(a, b, c)
        @state[c] = @state[a]
    end

    def seti(a, b, c)
        @state[c] = a
    end

    def gtir(a, b, c)
        @state[c] = a > @state[b] ? 1 : 0
    end

    def gtri(a, b, c)
        @state[c] = @state[a] > b ? 1 : 0
    end

    def gtrr(a, b, c)
        @state[c] = @state[a] > @state[b] ? 1 : 0
    end

    def eqir(a, b, c)
        @state[c] = a == @state[b] ? 1 : 0
    end

    def eqri(a, b, c)
        @state[c] = @state[a] == b ? 1 : 0
    end

    def eqrr(a, b, c)
        @state[c] = @state[a] == @state[b] ? 1 : 0
    end

    def reset
        @state = @original.dup
    end

    def resetInstructions(possibleInstructions)
        indexes = getInstructionIndexes(possibleInstructions)

        indexes.keys.each do |instruction|
            index = indexes[instruction]
            case instruction
            when "addr"
                @instructions[index] = self.method(:addr)
            when "addi"
                @instructions[index] = self.method(:addi)
            when "mulr"
                @instructions[index] = self.method(:mulr)
            when "muli"
                @instructions[index] = self.method(:muli)
            when "banr"
                @instructions[index] = self.method(:banr)
            when "bani"
                @instructions[index] = self.method(:bani)
            when "borr"
                @instructions[index] = self.method(:borr)
            when "bori"
                @instructions[index] = self.method(:bori)
            when "setr"
                @instructions[index] = self.method(:setr)
            when "seti"
                @instructions[index] = self.method(:seti)
            when "gtir"
                @instructions[index] = self.method(:gtir)
            when "gtri"
                @instructions[index] = self.method(:gtri)
            when "gtrr"
                @instructions[index] = self.method(:gtrr)
            when "eqir"
                @instructions[index] = self.method(:eqir)
            when "eqri"
                @instructions[index] = self.method(:eqri)
            when "eqrr"
                @instructions[index] = self.method(:eqrr)
            end
        end
    end

    def to_s
        return "#{@state}"
    end

    private

    def getInstructionIndexes(possibleInstructions)
        indexes = {}
        possibleInstructions.keys.each do |instruction|
            possibleInstructions[instruction] = possibleInstructions[instruction].uniq
        end

        count = 0
        done = false
        while !done
            possibleInstructions.keys.each do |instruction|
                if possibleInstructions[instruction].length == 1
                    index = possibleInstructions[instruction][0]
                    possibleInstructions.keys.each do |other|
                        if instruction != other
                            possibleInstructions[other].delete(index)
                        end
                    end
                    indexes[instruction] = index
                    possibleInstructions[instruction] = []
                    break
                end
            end

            done = true
            possibleInstructions.keys.each do |instruction|
                if possibleInstructions[instruction].length != 0
                    done = false
                end
            end
        end

        return indexes
    end
end

def getPossibleInstructions(before, instructions, after)
    result = []
    register = Register.new(before[0], before[1], before[2], before[3])
    register.instructions.each do |instruction|
        register.reset
        instruction.call(instructions[1], instructions[2], instructions[3])

        if (register.state[0] == after[0] and register.state[1] == after[1] and
            register.state[2] == after[2] and register.state[3] == after[3])
            result.push(instruction.name.to_s)
        end
    end

    return result
end

def chronalClassification(input)
    empty = 0
    programStarted = false

    register = Register.new(0, 0, 0, 0)

    possibleInstructions = Hash.new() { [] }
    before = []
    instruction = []
    after = []
    input.each do |line|
        if !programStarted
            if line.start_with?("Before")
                before = line[9..-2].split(",").map(&:to_i)
            elsif line.start_with?("After")
                after = line[9..-2].split(",").map(&:to_i)
                getPossibleInstructions(before, instruction, after).each do |name|
                    possibleInstructions[name] = possibleInstructions[name].push(instruction[0])
                end
            else
                instruction = line.split(" ").map(&:to_i)
            end

            if line.length == 2
                empty += 1
                if empty == 3
                    register.resetInstructions(possibleInstructions)
                    programStarted = true
                end
            else
                empty = 0
            end
        else
            instruction = line.split(" ").map(&:to_i)
            register.instructions[instruction[0]].call(instruction[1], instruction[2], instruction[3])
        end
    end

    return register.state[0]
end