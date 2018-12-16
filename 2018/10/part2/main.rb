require_relative "theStarsAlign"

def readInput()
    File.readlines("../input")
end

puts theStarsAlign(readInput())