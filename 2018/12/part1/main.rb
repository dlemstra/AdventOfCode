require_relative "subterraneanSustainability"

def readInput()
    File.readlines("input")
end

puts subterraneanSustainability(readInput())