def marbleMania(input)
    info = input.split
    scores = Array.new(info[0].to_i) { 0 }
    marbles = info[6].to_i

    index = 1
    marble = 0
    circle = [0]
    while marble != marbles
        marble += 1
        if marble % 23 == 0
            index -= 9
            if index < 0
                index = circle.length + index
            end
            score = marble + circle[index]
            scores[marble % scores.length] += score
            circle.delete_at(index)
        else
            circle.insert(index, marble)
        end

        index += 2
        if index != circle.length
            index = index % circle.length
        end
    end

    return scores.max
end