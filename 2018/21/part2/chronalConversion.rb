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
        when "bani"
            bani(register)
        when "bori"
            bori(register)
        when "eqri"
            eqri(register)
        when "eqrr"
            eqrr(register)
        when "gtir"
            gtir(register)
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
            puts "[NOT IMPLEMENTED: #{@name}]"
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

    def bani(register)
        register[@c] = register[@a] & @b
    end

    def bori(register)
        register[@c] = register[@a] | @b
    end

    def eqri(register)
        register[@c] = register[@a] == @b ? 1 : 0
    end

    def eqrr(register)
        register[@c] = register[@a] == register[@b] ? 1 : 0
    end

    def gtir(register)
        register[@c] = @a > register[@b] ? 1 : 0
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

def execute(ip, instructions, register)

    found = Hash.new(0)

    while true
        index = register[ip]
        instruction = instructions[index]
        instruction.execute(register)
        if index == 28 # HACK!
            if found[register[1]] == 1
                return found.keys[-1]
            else
                found[register[1]] = 1
                puts "#{register} #{found.length}"
            end
        end

        if register[ip] + 1 >= instructions.length
            break
        end
        register[ip] += 1
    end
end

def chronalConversion(input)
    ip = input.shift.split(" ")[1].to_i

    instructions = []
    input.each do |line|
        info = line.split(" ")
        instruction = Instruction.new(info[0], info[1], info[2], info[3])
        instructions.push(instruction)
    end

    register = ['0', 0, 0, 0, 0, 0, 0]
    result = execute(ip, instructions, register)

    return result
end