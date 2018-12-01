
def chronalCalibration(input)
    found = { 0 => 1 }
    frequency = 0
    while true
        input.each do |i|
            frequency += i
            if found[frequency]
                return frequency
            end
            found[frequency] = 1
        end
    end
    -1
end