require 'date'

class Guard
    def initialize(id)
        @id = id[1..-1].to_i
        @minutes = Hash.new(0)
    end
    attr_reader :id

    def sleep(timestamp)
        @start = timestamp
    end

    def wakeup(timestamp)
        while @start < timestamp
            @minutes[@start.min] += 1
            @start += Rational(60, 86400)
        end
    end

    def minutes_asleep
        return @minutes.values.sum
    end

    def bestMinute
        if @minutes.length == 0
            return 0
        end
        return @minutes.max_by{|k,v| v}[0]
    end

    def to_s()
        return "\##{@id} #{@minutes_asleep}"
    end
end

def reposeRecord(input)
    actions = {}
    input.each do |line|
        info = line.split
        timestamp = DateTime.parse("#{info[0][1..-1]} #{info[1][0..-2]}")
        action = info[3]
        actions[timestamp] = action
    end

    guards = {}
    guard = nil
    actions.sort.to_h.each do |timestamp, action|
        if action == "asleep"
            guard.sleep(timestamp)
        elsif action == "up"
            guard.wakeup(timestamp)
        else
            guard = guards[action]
            if guard.nil?
                guard = Guard.new(action)
                guards[action] = guard
            end
        end
    end

    best = nil
    guards.values.each do |guard|
        if best.nil?
            best = guard
        elsif best.minutes_asleep < guard.minutes_asleep
            best = guard
        end
    end

    return best.id * best.bestMinute
end