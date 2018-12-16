require_relative "alchemicalReduction"

def readInput()
    File.readlines("../input")
end

puts alchemicalReduction(readInput()[0])