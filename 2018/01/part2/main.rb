require_relative "chronalCalibration"

def readInput()
    File.readlines("input").map(&:to_i)
end

puts chronalCalibration(readInput())