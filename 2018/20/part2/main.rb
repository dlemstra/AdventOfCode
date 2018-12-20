require_relative "aRegularMap"

def readInput()
    File.readlines("../input")
end

puts aRegularMap(readInput()[0])