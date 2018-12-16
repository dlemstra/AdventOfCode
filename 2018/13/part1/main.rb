require_relative "mineCartMadness"

def readInput()
    File.readlines("../input")
end

puts mineCartMadness(readInput())