require_relative "theSumOfItsParts"

def readInput()
    File.readlines("input")
end

puts theSumOfItsParts(readInput(), 5, 60)