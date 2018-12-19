class Instruction
    def initialize(name, a, b, c)
        @name = name
        @a = a.to_i
        @b = b.to_i
        @c = c.to_i
    end

    def execute(register)

        case @name
        when "addi"
            addi(register)
        when "addr"
            addr(register)
        when "eqrr"
            eqrr(register)
        when "gtrr"
            gtrr(register)
        when "seti"
            seti(register)
        when "setr"
            setr(register)
        when "mulr"
            mulr(register)
        when "muli"
            muli(register)
        else
            puts "[NOT IMPLEMENTED ]"
            exit 0
        end
    end

    def to_s()
        return "#{@name} #{@a} #{@b} #{@c}"
    end

    private

    def addi(register)
        register[@c] = register[@a] + @b
    end

    def addr(register)
        register[@c] = register[@a] + register[@b]
    end

    def eqrr(register)
        register[@c] = register[@a] == register[@b] ? 1 : 0
    end

    def gtrr(register)
        register[@c] = register[@a] > register[@b] ? 1 : 0
    end

    def muli(register)
        register[@c] = register[@a] * @b
    end

    def mulr(register)
        register[@c] = register[@a] * register[@b]
    end

    def seti(register)
        register[@c] = @a
    end

    def setr(register)
        register[@c] = register[@a]
    end
end

def goWithTheFlow(input)
    ip = input.shift.split(" ")[1].to_i

    register = [1, 0, 0, 0, 0, 0, 0]
    instructions = []
    input.each do |line|
        info = line.split(" ")
        instruction = Instruction.new(info[0], info[1], info[2], info[3])
        instructions.push(instruction)
    end

    while register[ip] != 1
        index = register[ip]
        instruction = instructions[index]
        instruction.execute(register)

        if register[ip] + 1 >= instructions.length
            break
        end
        register[ip] += 1
    end

    items = []
    for i in 1..register[1]+1
        if register[1] % i == 0
            items.push(i)
        end
    end

    return items.sum
end