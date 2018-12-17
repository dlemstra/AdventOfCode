require_relative "reservoirResearch"

def readInput()
    File.readlines("../input")
end

puts reservoirResearch(readInput())