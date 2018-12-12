class Pot
    def initialize(plant, index)
        @plant = plant
        @index = index
        @newValue = plant
    end
    attr_reader :plant, :prev, :next, :newValue, :index
    attr_writer :plant, :prev, :next, :newValue

    def prepend
        pot = Pot.new(false, @index - 1)
        pot.next = self
        self.prev = pot

        return pot
    end

    def append
        pot = Pot.new(false, @index + 1)
        pot.prev = self
        self.next = pot

        return pot
    end

    def to_s
        return "#{@plant ? '#' : '.'}"
    end
end

class Note
    def initialize(info)
        @result = info[9] == '#' ? true : false
        @plant = info[2] == '#' ? true : false
        @prev = info[1] == '#' ? true : false
        @prevPrev = info[0] == '#' ? true : false
        @next = info[3] == '#' ? true : false
        @nextNext = info[4] == '#' ? true : false

        @str = info.join("")
    end

    def process(pot)
        if pot.plant != @plant
            return false
        end

        if pot.prev.plant != @prev
            return false
        end

        if pot.prev.prev.plant != @prevPrev
            return false
        end

        if pot.next.plant != @next
            return false
        end

        if pot.next.next.plant != @nextNext
            return false
        end

        pot.newValue = @result
        return true
    end

    def to_s
        return "#{@str}"
    end
end

def checkHead(head)
    if head.plant
        head = head.prepend()
        head = head.prepend()
        head = head.prepend()
        return head
    end

    if head.next.plant
        head = head.prepend()
        head = head.prepend()
        return head
    end

    if head.next.next.plant
        return head.prepend()
    end

    return head
end

def checkTail(tail)
    if tail.plant
        tail = tail.append()
        tail = tail.append()
        tail = tail.append()
        return tail
    end

    if tail.prev.plant
        tail = tail.append()
        tail = tail.append()
        return tail
    end

    if tail.prev.prev.plant
        return tail.append()
    end

    return tail
end

def updatePots(head)
    pot = head
    while !pot.nil?
        pot.plant = pot.newValue
        pot = pot.next
    end
end

def getTotal(head, delta = 0)
    total = 0
    pot = head
    while !pot.nil?
        if pot.plant
            total += pot.index + delta
        end
        pot = pot.next
    end

    return total
end

def subterraneanSustainability(input)

    head = nil
    tail = nil
    prev = nil

    index = 0
    first = input.shift.split(':')[1][1..-1]
    first.chars.each do |char|
        pot = Pot.new(char == '#' ? true : false, index)
        pot.prev = prev
        if head.nil?
            head = pot
        end
        if !prev.nil?
            prev.next = pot
        end
        prev = pot
        index += 1
    end

    tail = prev

    input.shift

    notes = []
    input.each do |line|
        note = Note.new(line.split(''))
        notes.push(note)
    end

    head = checkHead(head)
    tail = checkTail(tail)

    count = 20-1
    for i in 0..count
        pot = head.next.next
        while !pot.next.next.nil?
            pot.newValue = false
            for note in notes
                if note.process(pot)
                    break
                end
            end

            pot = pot.next
        end

        updatePots(head)

        head = checkHead(head)
        tail = checkTail(tail)
    end

    return getTotal(head)
end