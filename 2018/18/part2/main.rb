require_relative "settlersOfTheNorthPole"

def readInput()
    File.readlines("../input")
end

puts settlersOfTheNorthPole(readInput())