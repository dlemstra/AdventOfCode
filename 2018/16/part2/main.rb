require_relative "chronalClassification"

def readInput()
    File.readlines("../input")
end

puts chronalClassification(readInput())