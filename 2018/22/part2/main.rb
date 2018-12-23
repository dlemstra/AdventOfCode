require_relative "modeMaze"

def readInput()
    File.readlines("../input")
end

puts modeMaze(readInput())