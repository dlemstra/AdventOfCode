require_relative "chronalCoordinates"

def readInput()
    File.readlines("../input")
end

puts chronalCoordinates(readInput())