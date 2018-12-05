def doAlchemicalReduction(input, char)
    i = 0
    while i < input.length - 1 do
        if input[i] == char or input[i] == char.downcase
            input.slice!(i)
            if i > 0
                i -= 1
            end
            next
        elsif input[i] != input[i+1]
            if input[i].upcase == input[i+1].upcase
                input.slice!(i)
                input.slice!(i)
                if i > 0
                    i -= 1
                end
                next
            end
        end
        i += 1
    end

    return input.length
end

def alchemicalReduction(input)
    min = input.length
    input.upcase.chars.uniq.each do |char|

        filteredInput = input.dup
        len = doAlchemicalReduction(filteredInput, char)
        if (len < min)
            min = len
        end
    end

    return min
end