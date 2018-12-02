def hasDuplicates(input, count)
    cnt = 1
    i = 1
    for i in 1..input.length-1
        if input[i] == input[i-1]
            cnt += 1
        elsif cnt == count
            return true
        else
            cnt = 1
        end
    end
    return cnt == count
end

def inventoryManagementSystem(input)
    two = 0
    three = 0
    input.each do |str|
        chars = str.chars.sort
        if hasDuplicates(chars, 2)
            two += 1
        end
        if hasDuplicates(chars, 3)
            three += 1
        end
    end
    two * three
end