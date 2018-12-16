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

    def stateEqualTo(a, b, c, d)
        return (@state[0] == a and @state[1] == b and @state[2] == c and @state[3] == d)
    end

    def to_s
        return "#{@state}"
    end
end

def worksForThreeInstructions(before, instructions, after)
    count = 0
    register = Register.new(before[0], before[1], before[2], before[3])
    register.instructions.each do |instruction|
        register.reset
        instruction.call(instructions[1], instructions[2], instructions[3])
        if register.stateEqualTo(after[0], after[1], after[2], after[3])
            count += 1
            if count >= 3
                return true
            end
        end
    end

    return false
end

def chronalClassification(input)
    count = 0

    before = []
    instructions = []
    after = []
    input.each do |line|
        if line.start_with?("Before")
            before = line[9..-2].split(",").map(&:to_i)
        elsif line.start_with?("After")
            after = line[9..-2].split(",").map(&:to_i)
            if worksForThreeInstructions(before, instructions, after)
                count += 1
            end
        else
            instructions = line.split(" ").map(&:to_i)
        end
    end
    return count
end