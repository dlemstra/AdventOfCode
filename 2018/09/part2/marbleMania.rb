class Marble
    def initialize(value)
        @value = value
        @next = nil
        @prev = nil
    end
    attr_reader :value, :prev, :next
    attr_writer :prev, :next
end

def marbleMania(input, multiplication = 1)
    info = input.split
    scores = Array.new(info[0].to_i) { 0 }
    marbles = info[6].to_i

    marbles *= multiplication

    value = 1
    marble = Marble.new(value)

    head = marble
    prev = marble
    while value != marbles
        value += 1

        if value % 23 == 0
            i = 0
            while i < 8
                prev = prev.prev
                if prev == head
                    i += 1
                end
                i += 1
            end

            score = value + prev.value
            scores[(value-1) % scores.length] += score

            prev.next.prev = prev.prev
            prev.prev.next = prev.next

            prev = prev.next.next
        else
            marble = Marble.new(value)

            if prev.prev.nil?
                prev.prev = marble
                marble.next = prev
                marble.prev = prev
                head = marble
            elsif prev.next.nil?
                prev.next = marble
                marble.prev = prev
                marble.next = prev.prev
                prev.prev.prev = marble
            elsif prev == head
                marble.next = head
                marble.prev = head.prev
                head.prev.next = marble
                head.prev = marble
                head = marble
            else
                marble.next = prev.next
                prev.next.prev = marble

                prev.next = marble
                marble.prev = prev
            end

            prev = marble.next
        end
    end

    return scores.max
end