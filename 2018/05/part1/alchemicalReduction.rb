def alchemicalReduction(input)
    i = 0
    input.downcase
    while i < input.length - 1 do
        if input[i] != input[i+1]
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