require_relative "fourDimensionalAdventure.rb"

def readInput()
    File.readlines("../input")
end

puts fourDimensionalAdventure(readInput())